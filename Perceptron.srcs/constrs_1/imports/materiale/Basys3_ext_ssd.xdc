# This file is a general .xdc for the Basys3 rev B board
# To use it in a project
# - uncomment the lines corresponding to used pins
# - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 
# Switches
set_property PACKAGE_PIN V17 [get_ports {sw[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property PACKAGE_PIN V16 [get_ports {sw[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property PACKAGE_PIN W16 [get_ports {sw[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property PACKAGE_PIN W17 [get_ports {sw[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
set_property PACKAGE_PIN W15 [get_ports {sw[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
set_property PACKAGE_PIN V15 [get_ports {sw[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
set_property PACKAGE_PIN W14 [get_ports {sw[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
set_property PACKAGE_PIN W13 [get_ports {sw[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]
set_property PACKAGE_PIN V2 [get_ports {sw[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]
set_property PACKAGE_PIN T3 [get_ports {sw[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[9]}]
set_property PACKAGE_PIN T2 [get_ports {sw[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[10]}]
set_property PACKAGE_PIN R3 [get_ports {sw[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[11]}]
set_property PACKAGE_PIN W2 [get_ports {sw[12]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[12]}]
set_property PACKAGE_PIN U1 [get_ports {sw[13]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[13]}]
set_property PACKAGE_PIN T1 [get_ports {sw[14]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[14]}]
set_property PACKAGE_PIN R2 [get_ports {sw[15]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[15]}]
 

# LEDs
set_property PACKAGE_PIN U16 [get_ports {led[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property PACKAGE_PIN E19 [get_ports {led[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property PACKAGE_PIN U19 [get_ports {led[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property PACKAGE_PIN V19 [get_ports {led[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
set_property PACKAGE_PIN W18 [get_ports {led[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
set_property PACKAGE_PIN U15 [get_ports {led[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
set_property PACKAGE_PIN U14 [get_ports {led[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
set_property PACKAGE_PIN V14 [get_ports {led[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]
set_property PACKAGE_PIN V13 [get_ports {led[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[8]}]
set_property PACKAGE_PIN V3 [get_ports {led[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[9]}]
set_property PACKAGE_PIN W3 [get_ports {led[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[10]}]
set_property PACKAGE_PIN U3 [get_ports {led[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[11]}]
set_property PACKAGE_PIN P3 [get_ports {led[12]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[12]}]
set_property PACKAGE_PIN N3 [get_ports {led[13]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[13]}]
set_property PACKAGE_PIN P1 [get_ports {led[14]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[14]}]
set_property PACKAGE_PIN L1 [get_ports {led[15]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[15]}]
	
	
#7 catment display
set_property PACKAGE_PIN W7 [get_ports {cat[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {cat[0]}]
set_property PACKAGE_PIN W6 [get_ports {cat[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {cat[1]}]
set_property PACKAGE_PIN U8 [get_ports {cat[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {cat[2]}]
set_property PACKAGE_PIN V8 [get_ports {cat[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {cat[3]}]
set_property PACKAGE_PIN U5 [get_ports {cat[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {cat[4]}]
set_property PACKAGE_PIN V5 [get_ports {cat[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {cat[5]}]
set_property PACKAGE_PIN U7 [get_ports {cat[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {cat[6]}]



set_property PACKAGE_PIN U2 [get_ports {an[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
set_property PACKAGE_PIN U4 [get_ports {an[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
set_property PACKAGE_PIN V4 [get_ports {an[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
set_property PACKAGE_PIN W4 [get_ports {an[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]


#Buttons c u l r d
set_property PACKAGE_PIN U18 [get_ports {btnc}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {btnc}]
set_property PACKAGE_PIN T18 [get_ports {btnu}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {btnu}]
set_property PACKAGE_PIN W19 [get_ports {btnl}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {btnl}]
set_property PACKAGE_PIN T17 [get_ports btnr]						
	set_property IOSTANDARD LVCMOS33 [get_ports {btnr}]
set_property PACKAGE_PIN U17 [get_ports {btnd}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {btnd}]
	
	
	##Pmod Header JB
#Sch name = JB1
set_property PACKAGE_PIN K17 [get_ports {ecat[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ecat[4]}]
#Sch name = JB2
set_property PACKAGE_PIN M18 [get_ports {ecat[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ecat[7]}]
#Sch name = JB3
set_property PACKAGE_PIN N17 [get_ports {ecat[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ecat[6]}]
##Sch name = JB4
#set_property PACKAGE_PIN B16 [get_ports {JB[3]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {JB[3]}]
#Sch name = JB7
set_property PACKAGE_PIN L17 [get_ports {ecat[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ecat[3]}]
#Sch name = JB8
set_property PACKAGE_PIN M19 [get_ports {ecat[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ecat[2]}]
#Sch name = JB9
set_property PACKAGE_PIN P17 [get_ports {ean[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ean[0]}]
##Sch name = JB10 
#set_property PACKAGE_PIN C16 [get_ports {JB[7]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {JB[7]}]
 


##Pmod Header JC
#Sch name = JC1
set_property PACKAGE_PIN A14 [get_ports {ecat[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ecat[1]}]
#Sch name = JC2
set_property PACKAGE_PIN A16 [get_ports {ean[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ean[2]}]
#Sch name = JC3
set_property PACKAGE_PIN B15 [get_ports {ecat[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ecat[0]}]
#Sch name = JC4
#set_property PACKAGE_PIN P18 [get_ports {JC[3]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {JC[3]}]
#Sch name = JC7
set_property PACKAGE_PIN A15 [get_ports {ean[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ean[1]}]
#Sch name = JC8
set_property PACKAGE_PIN A17 [get_ports {ecat[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ecat[5]}]
##Sch name = JC9
set_property PACKAGE_PIN C15 [get_ports {ean[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ean[3]}]
#Sch name = JC10
#set_property PACKAGE_PIN R18 [get_ports {JC[7]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {JC[7]}]
 

