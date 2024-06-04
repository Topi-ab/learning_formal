#!/bin/bash

docker run --pull always -v $PWD:/formal -w /formal --rm -it hdlc/formal:all bash -c "yosys -m ghdl ex_1.ys && yosys -m ghdl ex_2.ys && sby --yosys 'yosys -m ghdl' -f compare_1.sby $@"