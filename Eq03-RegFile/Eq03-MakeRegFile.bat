ghdl --clean
ghdl --remove

ghdl -a Eq03-reg16bits.vhd                                              
ghdl -a Eq03-RegFile.vhd
ghdl -a Eq03-RegFile_tb.vhd
ghdl -r register_file_tb --stop-time=1500ns --wave=Eq03-RegFile.ghw --ieee-asserts=disable-at-0 
gtkwave Eq03-RegFile.ghw Eq03-RegFile.gtkw
