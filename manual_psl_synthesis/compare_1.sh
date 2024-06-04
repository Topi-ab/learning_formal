#!/bin/bash

#yosys -m ghdl psl_p_plus.ys
#sby --yosys "yosys -m ghdl" -f compare_psl_p_plus.sby compare cover

docker run --pull always -v $PWD:/formal -w /formal --rm -it hdlc/formal:all bash -c "yosys -m ghdl ex_1.ys && sby --yosys 'yosys -m ghdl' -f compare_1.sby $@"