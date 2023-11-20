ghdl --clean
ghdl --remove

ghdl -a Eq03-maq_estados.vhd                                              
ghdl -a Eq03-PC.vhd                                              
ghdl -a Eq03-Reg16bits.vhd                                              
ghdl -a Eq03-RegFile.vhd                                              
ghdl -a Eq03-ROM_PC_UC.vhd                                                                                            
ghdl -a Eq03-ROM.vhd                                              
ghdl -a Eq03-UC.vhd                                              
ghdl -a Eq03-ULA.vhd                                              
ghdl -a Eq03-ULARegs.vhd                                              
ghdl -a Eq03-Calc_tb.vhd

ghdl -r ROM_PC_UC_tb --stop-time=6000ns --wave=Eq03-Calc.ghw --ieee-asserts=disable-at-0 
REM gtkwave Eq03-Calc.ghw Eq03-Calc.gtkw