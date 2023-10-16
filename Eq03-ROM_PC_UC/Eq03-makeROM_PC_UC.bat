ghdl --clean
ghdl --remove

ghdl -a Eq03-rom.vhd                                              
ghdl -a Eq03-pc.vhd
ghdl -a Eq03-maq_estados.vhd
ghdl -a teste.vhd
@REM ghdl -a Eq03-ROM_PC_UC.vhd
@REM ghdl -a ROM_PC_UC_tb.vhd 

ghdl -r tb --stop-time=800ns --wave=Eq03-ROM_PC_UC.ghw --ieee-asserts=disable-at-0 
gtkwave Eq03-ROM_PC_UC.ghw Eq03-ROM_PC_UC.gtkw