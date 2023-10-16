ghdl --clean
ghdl --remove

ghdl -a Eq03-rom.vhd                                              
ghdl -a Eq03-pc.vhd
ghdl -a Eq03-maq_estados.vhd
ghdl -a Eq03-uc.vhd
ghdl -a Eq03-ROM_PC_UC.vhd
ghdl -a Eq03-ROM_PC_UC_tb.vhd 

ghdl -r ROM_PC_UC_tb --stop-time=5000ns --wave=Eq03-ROM_PC_UC.ghw --ieee-asserts=disable-at-0 
:: gtkwave Eq03-ROM_PC_UC.ghw Eq03-ROM_PC_UC.gtkw