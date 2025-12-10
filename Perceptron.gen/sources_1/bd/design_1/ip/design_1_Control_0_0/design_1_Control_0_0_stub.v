// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
// Date        : Tue Dec  9 21:08:13 2025
// Host        : Vasile-Laptop running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/Facultate/AN3/Sem1/SSC/Proiect/Perceptron-FPGA_delta_perceptron/Perceptron-FPGA_delta_perceptron/Perceptron-FPGA/Perceptron.gen/sources_1/bd/design_1/ip/design_1_Control_0_0/design_1_Control_0_0_stub.v
// Design      : design_1_Control_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "Control,Vivado 2024.1" *)
module design_1_Control_0_0(clk, input_val, sel_input, update_input, w, rst, 
  start_per, update_w, done_per, per_out, sel_corrected_w, sel_w, start_delta, 
  desired_point_type, corrected_w, delta_ok, delta_done)
/* synthesis syn_black_box black_box_pad_pin="input_val[31:0],sel_input,w[31:0],rst,start_per,done_per,per_out,sel_corrected_w[1:0],sel_w[1:0],start_delta,desired_point_type,corrected_w[31:0],delta_ok,delta_done" */
/* synthesis syn_force_seq_prim="clk" */
/* synthesis syn_force_seq_prim="update_input" */
/* synthesis syn_force_seq_prim="update_w" */;
  input clk /* synthesis syn_isclock = 1 */;
  input [31:0]input_val;
  input sel_input;
  input update_input /* synthesis syn_isclock = 1 */;
  input [31:0]w;
  input rst;
  input start_per;
  input update_w /* synthesis syn_isclock = 1 */;
  output done_per;
  output per_out;
  input [1:0]sel_corrected_w;
  input [1:0]sel_w;
  input start_delta;
  input desired_point_type;
  output [31:0]corrected_w;
  output delta_ok;
  output delta_done;
endmodule
