ghdl --clean
ghdl --remove

ghdl -a Eq03-ULA.vhd                                                 
ghdl -a Eq03-ULA_tb.vhd
ghdl -r ula_tb --wave=Eq03-ULA.ghw --ieee-asserts=disable-at-0 
gtkwave Eq03-ULA.ghw
