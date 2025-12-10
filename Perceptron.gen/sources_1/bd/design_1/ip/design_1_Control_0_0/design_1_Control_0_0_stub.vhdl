-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
-- Date        : Tue Dec  9 21:08:13 2025
-- Host        : Vasile-Laptop running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/Facultate/AN3/Sem1/SSC/Proiect/Perceptron-FPGA_delta_perceptron/Perceptron-FPGA_delta_perceptron/Perceptron-FPGA/Perceptron.gen/sources_1/bd/design_1/ip/design_1_Control_0_0/design_1_Control_0_0_stub.vhdl
-- Design      : design_1_Control_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_Control_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    input_val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    sel_input : in STD_LOGIC;
    update_input : in STD_LOGIC;
    w : in STD_LOGIC_VECTOR ( 31 downto 0 );
    rst : in STD_LOGIC;
    start_per : in STD_LOGIC;
    update_w : in STD_LOGIC;
    done_per : out STD_LOGIC;
    per_out : out STD_LOGIC;
    sel_corrected_w : in STD_LOGIC_VECTOR ( 1 downto 0 );
    sel_w : in STD_LOGIC_VECTOR ( 1 downto 0 );
    start_delta : in STD_LOGIC;
    desired_point_type : in STD_LOGIC;
    corrected_w : out STD_LOGIC_VECTOR ( 31 downto 0 );
    delta_ok : out STD_LOGIC;
    delta_done : out STD_LOGIC
  );

end design_1_Control_0_0;

architecture stub of design_1_Control_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,input_val[31:0],sel_input,update_input,w[31:0],rst,start_per,update_w,done_per,per_out,sel_corrected_w[1:0],sel_w[1:0],start_delta,desired_point_type,corrected_w[31:0],delta_ok,delta_done";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "Control,Vivado 2024.1";
begin
end;
