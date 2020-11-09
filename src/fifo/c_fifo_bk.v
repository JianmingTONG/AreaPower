// $Id: c_fifo.v 5188 2012-08-30 00:31:31Z dub $

/*
 Copyright (c) 2007-2012, Trustees of The Leland Stanford Junior University
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 Redistributions of source code must retain the above copyright notice, this 
 list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this
 list of conditions and the following disclaimer in the documentation and/or
 other materials provided with the distribution.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

//==============================================================================
// generic FIFO buffer built from registers
//==============================================================================

module c_fifo
  (clk, reset, push_active, pop_active, push, pop, push_data, pop_data, 
   almost_empty, empty, full, errors);
   
`include "c_functions.v"
`include "c_constants.v"

   // number of entries in FIFO
parameter depth = 4096;
   
   // width of each entry
   parameter width = 8;
   
   // select implementation variant for register file
   parameter regfile_type = `REGFILE_TYPE_FF_2D;
   
   // if enabled, feed through inputs to outputs when FIFO is empty
   parameter enable_bypass = 0;
   
   parameter reset_type = `RESET_TYPE_ASYNC;
   
   // width required for read/write address
   localparam addr_width = clogb(depth);
   
   input clk;
   input reset;
   input push_active;
   input pop_active;
   
   // write (add) an element
   input push;
   
   // read (remove) an element
   input pop;
   
   // data to write to FIFO
   input [0:width-1] push_data;
   
   // data being read from FIFO
   output [0:width-1] pop_data;
   wire [0:width-1]   pop_data;
   
   // buffer nearly empty (1 used slot remaining) indication
   output 	      almost_empty;
   wire 	      almost_empty;
   
   // buffer empty indication
   output 	      empty;
   wire 	      empty;
   
   // buffer full indication
   output 	      full;
   wire 	      full;
   
   // internal error condition detected
   output [0:1]       errors;
   wire [0:1] 	      errors;
   
   wire 	      error_underflow;
   wire 	      error_overflow;
   
   generate
      
      if(depth == 0)
	begin
	   
	   if(enable_bypass)
	     assign pop_data = push_data;
	   
	   assign almost_empty = 1'b0;
	   assign empty = 1'b1;
	   assign full = 1'b1;
	   
	   assign error_underflow = pop;
	   assign error_overflow = push;
	   
	   assign errors[0] = error_underflow;
	   assign errors[1] = error_overflow;
	   
	end
      else if(depth == 1)
	begin
	   
	   wire [0:width-1] data_s, data_q;
	   assign data_s = push ? push_data : data_q;
	   c_dff#(.width(width),
	       .reset_type(reset_type))
	   dataq
	     (.clk(clk),
	      .reset(1'b0),
	      .active(push_active),
	      .d(data_s),
	      .q(data_q));
	   
	   if(enable_bypass)
	     assign pop_data = empty ? push_data : data_q;
	   else
	     assign pop_data = data_q;
	   
	   wire 	    empty_active;
	   assign empty_active = push_active | pop_active;
	   
	   wire 	    empty_s, empty_q;
	   assign empty_s = (empty_q & ~push) | pop;
	   c_dff#(.width(1),
	       .reset_value(1'b1),
	       .reset_type(reset_type))
	   emptyq
	     (.clk(clk),
	      .reset(reset),
	      .active(empty_active),
	      .d(empty_s),
	      .q(empty_q));
	   
	   assign almost_empty = ~empty_q;
	   assign empty = empty_q;
	   assign full = ~empty_q;
	   
	   wire 	    error_underflow;
	   if(enable_bypass)
	     assign error_underflow = empty_q & pop & ~push;
	   else
	     assign error_underflow = empty_q & pop;
	   
	   wire 	    error_overflow;
	   assign error_overflow = ~empty_q & push;
	   
	   assign errors[0] = error_underflow;
	   assign errors[1] = error_overflow;
	   
	end
      else if(depth > 1)
	begin
	   
	   wire [0:addr_width-1] push_addr;
	   wire [0:addr_width-1] pop_addr;
	   c_fifo_ctrl#(.depth(depth),
	       .enable_bypass(enable_bypass),
	       .reset_type(reset_type))
	   ctrl
	     (.clk(clk),
	      .reset(reset),
	      .push_active(push_active),
	      .pop_active(pop_active),
	      .push(push),
	      .pop(pop),
	      .push_addr(push_addr),
	      .pop_addr(pop_addr),
	      .almost_empty(almost_empty),
	      .empty(empty),
	      .full(full),
	      .errors(errors));
	   
	   assign error_underflow = errors[0];
	   assign error_overflow = errors[1];
	   
	   wire [0:width-1] 	 rf_data;
	   c_regfile#(.depth(depth),
	       .width(width),
	       .regfile_type(regfile_type))
	   rf
	     (.clk(clk),
	      .write_active(push_active),
	      .write_enable(push),
	      .write_address(push_addr),
	      .write_data(push_data),
	      .read_address(pop_addr),
	      .read_data(rf_data));
	   
	   if(enable_bypass)
	     assign pop_data = empty ? push_data : rf_data;
	   else
	     assign pop_data = rf_data;
	   
	end
      
   endgenerate
   
endmodule


module c_dff
  (clk, reset, active, d, q);
   
`include "c_constants.v"
   
   // width of register
   parameter width = 32;
   
   // offset (left index) of register
   parameter offset = 0;
   
   parameter reset_type = `RESET_TYPE_ASYNC;
   
   parameter [offset:(offset+width)-1] reset_value = {width{1'b0}};
   
   input clk;
   input reset;
   input active;
   
   // data input
   input [offset:(offset+width)-1] d;
   
   // data output
   output [offset:(offset+width)-1] q;
   reg [offset:(offset+width)-1] q;
   
   generate
      
      case(reset_type)
	
	`RESET_TYPE_ASYNC:
	  always @(posedge clk, posedge reset)
	    if(reset)
	      q <= reset_value;
	    else if(active)
	      q <= d;
	
	`RESET_TYPE_SYNC:
	  always @(posedge clk)
	    if(reset)
	      q <= reset_value;
	    else if(active)
	      q <= d;
	
      endcase 
      
   endgenerate
   
endmodule


//==============================================================================
// simple FIFO controller
//==============================================================================

module c_fifo_ctrl
  (clk, reset, push_active, pop_active, push, pop, push_addr, pop_addr, 
   almost_empty, empty, full, errors);
   
`include "c_functions.v"
`include "c_constants.v"
   
   // number of entries in FIFO
parameter depth = 4096;
   
   // add additional address bits
   parameter extra_addr_width = 0;
   
   // address width
   localparam addr_width = clogb(depth) + extra_addr_width;
   
   // starting address (i.e., address of leftmost entry)
   parameter offset = 0;
   
   // minimum (leftmost) address
   localparam [0:addr_width-1] min_value = offset;
   
   // maximum (rightmost) address
   localparam [0:addr_width-1] max_value = offset + depth - 1;
   
   // generate the almost_empty output early in the clock cycle
   parameter fast_almost_empty = 0;
   
   // allow bypassing through empty FIFO (i.e., empty & push & pop)
   parameter enable_bypass = 0;
   
   parameter reset_type = `RESET_TYPE_ASYNC;
   
   input clk;
   input reset;
   input push_active;
   input pop_active;
   
   // write (add) an element
   input push;
   
   // read (remove) an element
   input pop;
   
   // address to write current input element to
   output [0:addr_width-1] push_addr;
   wire [0:addr_width-1]   push_addr;
   
   // address to read current output element from
   output [0:addr_width-1] pop_addr;
   wire [0:addr_width-1]   pop_addr;
   
   // buffer nearly empty (1 used slot remaining) indication
   output 		   almost_empty;
   wire 		   almost_empty;
   
   // buffer empty indication
   output 		   empty;
   wire 		   empty;
   
   // buffer full indication
   output 		   full;
   wire 		   full;
   
   // internal error condition detected
   output [0:1] 	   errors;
   wire [0:1] 		   errors;
   
   wire 		   active;
   assign active = push_active | pop_active;
   
   generate
      
      if(depth == 1)
	begin
	   
	   assign push_addr = min_value;
	   assign pop_addr = min_value;
	   
	   wire empty_s, empty_q;
	   assign empty_s = (empty_q & ~push) | pop;
	   c_dff
	     #(.width(1),
	       .reset_value(1'b1),
	       .reset_type(reset_type))
	   emptyq
	     (.clk(clk),
	      .reset(reset),
	      .active(active),
	      .d(empty_s),
	      .q(empty_q));
	   
	   assign almost_empty = ~empty_q;
	   assign empty = empty_q;
	   assign full = ~empty_q;
	   
	end
      else if(depth > 1)
	begin
	   
	   wire [0:addr_width-1] push_addr_q;
	   
	   wire [0:addr_width-1] push_addr_next;
	   c_incr
	     #(.width(addr_width),
	       .min_value(min_value),
	       .max_value(max_value))
	   push_addr_incr
	     (.data_in(push_addr_q),
	      .data_out(push_addr_next));
	   
	   wire [0:addr_width-1] push_addr_prev;
	   c_decr
	     #(.width(addr_width),
	       .min_value(min_value),
	       .max_value(max_value))
	   push_addr_decr
	     (.data_in(push_addr_q),
	      .data_out(push_addr_prev));
	   
	   wire [0:addr_width-1] push_addr_s;
	   assign push_addr_s = push ? push_addr_next : push_addr_q;
	   c_dff
	     #(.width(addr_width),
	       .reset_value(min_value),
	       .reset_type(reset_type))
	   push_addrq
	     (.clk(clk),
	      .reset(reset),
	      .active(push_active),
	      .d(push_addr_s),
	      .q(push_addr_q));
	   
	   assign push_addr = push_addr_q;
	   
	   wire [0:addr_width-1] pop_addr_q;
	   
	   wire [0:addr_width-1] pop_addr_next;
	   c_incr
	     #(.width(addr_width),
	       .min_value(min_value),
	       .max_value(max_value))
	   pop_addr_incr
	     (.data_in(pop_addr_q),
	      .data_out(pop_addr_next));
	   
	   wire [0:addr_width-1] pop_addr_prev;
	   c_decr
	     #(.width(addr_width),
	       .min_value(min_value),
	       .max_value(max_value))
	   pop_addr_decr
	     (.data_in(pop_addr_q),
	      .data_out(pop_addr_prev));
	   
	   wire [0:addr_width-1] pop_addr_s;
	   assign pop_addr_s = pop ? pop_addr_next : pop_addr_q;
	   c_dff
	     #(.width(addr_width),
	       .reset_value(min_value),
	       .reset_type(reset_type))
	   pop_addrq
	     (.clk(clk),
	      .reset(reset),
	      .active(pop_active),
	      .d(pop_addr_s),
	      .q(pop_addr_q));
	   
	   assign pop_addr = pop_addr_q;

	   if(fast_almost_empty)
	     begin
		
		wire equal;
		assign equal = (push_addr_q == pop_addr_q);
		
		wire next_almost_empty;
		assign next_almost_empty = (push_addr_prev == pop_addr_next);
		
		wire almost_empty_s, almost_empty_q;
		if(enable_bypass)
		  assign almost_empty_s = (almost_empty & ~(push ^ pop)) | 
					  (next_almost_empty & (~push & pop)) |
					  (equal & (push & ~pop));
		else
		  assign almost_empty_s = (almost_empty & ~(push ^ pop)) | 
					  (next_almost_empty & (~push & pop)) |
					  (equal & push);
		c_dff
		  #(.width(1),
		    .reset_type(reset_type))
		almost_emptyq
		  (.clk(clk),
		   .reset(reset),
		   .active(active),
		   .d(almost_empty_s),
		   .q(almost_empty_q));
		
		assign almost_empty = almost_empty_q;
		
	     end
	   else
	     assign almost_empty = (push_addr_prev == pop_addr_q);
	   
	   wire 		 next_empty;
	   assign next_empty = (push_addr_q == pop_addr_next);
	   
	   wire 		 empty_s, empty_q;
	   if(enable_bypass)
	     assign empty_s = (empty & ~(push & ~pop)) | 
			      (next_empty & (~push & pop));
	   else
	     assign empty_s = (empty | (next_empty & pop)) & ~push;
	   c_dff
	     #(.width(1),
	       .reset_value(1'b1),
	       .reset_type(reset_type))
	   emptyq
	     (.clk(clk),
	      .reset(reset),
	      .active(active),
	      .d(empty_s),
	      .q(empty_q));
	   
	   assign empty = empty_q;
	   
	   wire 		 next_full;
	   assign next_full = (push_addr_next == pop_addr_q);
	   
	   wire 		 full_s, full_q;
	   assign full_s = (full | (next_full & push)) & ~pop;
	   c_dff
	     #(.width(1),
	       .reset_type(reset_type))
	   fullq
	     (.clk(clk),
	      .reset(reset),
	      .active(active),
	      .d(full_s),
	      .q(full_q));
	   
	   assign full = full_q;
	   
	end
      
      // synopsys translate_off
      
      else
	begin
	   initial
	   begin
	      $display({"ERROR: FIFO controller module %m requires a depth ", 
			"of at least one entry."});
	      $stop;
	   end
	end
      
      // synopsys translate_on
      
   endgenerate
   
   wire 			 error_underflow;
   
   generate
      
      if(enable_bypass)
	assign error_underflow = empty & ~push & pop;
      else
	assign error_underflow = empty & pop;
      
   endgenerate
   
   wire 			 error_overflow;
   assign error_overflow = full & push;
   
   // synopsys translate_off
   
   always @(posedge clk)
     begin
	
	if(error_underflow)
	  $display("ERROR: FIFO underflow in module %m.");
	
	if(error_overflow)
	  $display("ERROR: FIFO overflow in module %m.");
	
     end
   
   // synopsys translate_on
   
   assign errors[0] = error_underflow;
   assign errors[1] = error_overflow;
   
endmodule


//==============================================================================
// generic register file
//==============================================================================

module c_regfile
  (clk, write_active, write_enable, write_address, write_data, read_address, 
   read_data);
   
`include "c_functions.v"
`include "c_constants.v"
   
   // number of entries
parameter depth = 4096;
   
   // width of each entry
   parameter width = 64;
   
   // number of write ports
   parameter num_write_ports = 1;
   
   // number of read ports
   parameter num_read_ports = 1;
   
   // select implementation variant
   parameter regfile_type = `REGFILE_TYPE_FF_2D;
   
   // width required to swelect an entry
   localparam addr_width = clogb(depth);
   
   input clk;
   
   input write_active;
   
   // if high, write to entry selected by write_address
   input [0:num_write_ports-1] write_enable;
   
   // entry to be written to
   input [0:num_write_ports*addr_width-1] write_address;
   
   // data to be written
   input [0:num_write_ports*width-1] 	  write_data;
   
   // entries to read out
   input [0:num_read_ports*addr_width-1]  read_address;
   
   // contents of entries selected by read_address
   output [0:num_read_ports*width-1] 	  read_data;
   wire [0:num_read_ports*width-1] 	  read_data;
   
   genvar 				  read_port;
   genvar 				  write_port;
   
   generate
      
      case(regfile_type)
	
	`REGFILE_TYPE_FF_2D:
	  begin
	     
	     if(num_write_ports == 1)
	       begin
		  
		  reg [0:width-1] storage_2d [0:depth-1];
		  
		  always @(posedge clk)
		    if(write_active)
		      if(write_enable)
			storage_2d[write_address] <= write_data;
		  
		  for(read_port = 0; read_port < num_read_ports; 
		      read_port = read_port + 1)
		    begin:read_ports_2d
		       
		       wire [0:addr_width-1] port_read_address;
		       assign port_read_address
			 = read_address[read_port*addr_width:
					(read_port+1)*addr_width-1];
		       
		       wire [0:width-1]      port_read_data;
		       assign port_read_data = storage_2d[port_read_address];
		       
		       assign read_data[read_port*width:(read_port+1)*width-1]
			 = port_read_data;
		       
		    end
		  
	       end
	     else
	       begin
		  
		  // synopsys translate_off
		  initial
		    begin
		       $display({"ERROR: Register file %m does not support ",
				 "2D FF array register file models with %d ",
				 "write ports."}, num_write_ports);
		       $stop;
		    end
		  // synopsys translate_on
		  
	       end
	     
	  end
	
	`REGFILE_TYPE_FF_1D_MUX, `REGFILE_TYPE_FF_1D_SEL:
	  begin
	     
	     wire [0:num_write_ports*depth-1] write_sel_by_port;

	     for(write_port = 0; write_port < num_write_ports;
		 write_port = write_port + 1)
	       begin:write_ports_1d
		  
		  wire [0:addr_width-1] port_write_address;
		  assign port_write_address
		    = write_address[write_port*addr_width:
				    (write_port+1)*addr_width-1];
		  
		  wire [0:depth-1] 	port_write_sel;
		  c_decode
		    #(.num_ports(depth))
		  port_write_sel_dec
		    (.data_in(port_write_address),
		     .data_out(port_write_sel));
		  
		  assign write_sel_by_port[write_port*depth:
					   (write_port+1)*depth-1]
		    = port_write_sel;
		  
	       end
	     
	     wire [0:depth*num_write_ports-1] write_sel_by_level;
	     c_interleave
	       #(.width(num_write_ports*depth),
		 .num_blocks(num_write_ports))
	     write_sel_by_level_intl
	       (.data_in(write_sel_by_port),
		.data_out(write_sel_by_level));
	     
	     wire [0:depth*width-1] 	      storage_1d;
	     
	     genvar 			      level;
	     
	     for(level = 0; level < depth; level = level + 1)
	       begin:levels
		  
		  wire [0:num_write_ports-1] lvl_write_sel;
		  assign lvl_write_sel
		    = write_sel_by_level[level*num_write_ports:
					 (level+1)*num_write_ports-1];
		  
		  wire [0:num_write_ports-1] lvl_port_write;
		  assign lvl_port_write = write_enable & lvl_write_sel;
		  
		  wire 			     lvl_write_enable;
		  assign lvl_write_enable = |lvl_port_write;
		  
		  wire [0:width-1] 	     lvl_write_data;
		  c_select_1ofn
		    #(.num_ports(num_write_ports),
		      .width(width))
		  lvl_write_data_sel
		    (.select(lvl_port_write),
		     .data_in(write_data),
		     .data_out(lvl_write_data));
		  
		  reg [0:width-1] 	     storage;
		  
		  always @(posedge clk)
		    if(write_active)
		      if(lvl_write_enable)
			storage <= lvl_write_data;
		  
		  assign storage_1d[level*width:(level+1)*width-1] = storage;
		  
	       end
	     
	     for(read_port = 0; read_port < num_read_ports; 
		 read_port = read_port + 1)
	       begin:read_ports_1d
		  
		  wire [0:addr_width-1] port_read_address;
		  assign port_read_address
		    = read_address[read_port*addr_width:
				   (read_port+1)*addr_width-1];
		  
		  wire [0:width-1] 	port_read_data;
		  
		  case(regfile_type)
		    
		    `REGFILE_TYPE_FF_1D_SEL:
		      begin
			 
			 wire [0:depth-1] port_read_sel;
			 c_decode
			   #(.num_ports(depth))
			 port_read_sel_dec
			   (.data_in(port_read_address),
			    .data_out(port_read_sel));
			 
			 c_select_1ofn
			   #(.num_ports(depth),
			     .width(width))
			 port_read_data_sel
			   (.select(port_read_sel),
			    .data_in(storage_1d),
			    .data_out(port_read_data));
			 
		      end
		    
		    `REGFILE_TYPE_FF_1D_MUX:
		      begin
			 
			 assign port_read_data
			   = storage_1d[port_read_address*width +: width];
			 
		      end
		    
		  endcase
		  
		  assign read_data[read_port*width:(read_port+1)*width-1]
		    = port_read_data;
		  
	       end
	     
	  end
	
      endcase
      
      
      //----------------------------------------------------------------------
      // check parameter validity
      //----------------------------------------------------------------------
      
      // synopsys translate_off
      
      if(depth < 2)
	begin
	   initial
	     begin
		$display({"ERROR: Register file module %m requires a depth ", 
			  "of two or more entries."});
		$stop;
	     end
	end
      
      // synopsys translate_on
      
   endgenerate
   
endmodule
