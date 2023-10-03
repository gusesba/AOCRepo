ghdl --clean
ghdl --remove

ghdl -a Eq03-reg16bits.vhd                                              
ghdl -a Eq03-RegFile.vhd
ghdl -a Eq03-ULA.vhd
ghdl -a Eq03-ULARegs.vhd 
ghdl -a Eq03-ULARegs_tb.vhd 
ghdl -r ULARegs_tb --stop-time=1500ns --wave=Eq03-ULARegs.ghw --ieee-asserts=disable-at-0 
gtkwave Eq03-ULARegs.ghw Eq03-ULARegs.gtkw
