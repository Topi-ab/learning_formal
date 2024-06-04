# learning_formal

This is an excercise project to learn how PSL checkers actually behave. You can create an PSL assert -checker, and manually make corresponding VHDL checker, and run formal verification to verify your understanding of the PSL checker's behaviour matches the real one.

## project contents

_manual_psl_synthesis/_ has VHDL based formal testbench, in which simple PSL checkers are compared to hand crafted VHDL based checkers.

run<br>
`. compare_1.sh prove`<br>
This checks k-induction on all example cases.

`. compare_1.sh compare`<br>
This checks first 10 cycles of the comparator.

_compare_1.vhdl_ instantiates different example cases, and compares if the hand crafted checker results are equal to PSL results.

_ex_1.vhdl_ has a simple PSL assertion (_psl_assert_) and two processes to do the same checker with VHDL constructs.<br>
This file will be compiled to verilog (_ex_1.v_) using yosys script _ex_1.ys_, which also routes PSL $assert cell signals out from the module.<br>
PSL $assert cell has two inputs, EN & A. If EN is high and A is low, then assert failed.

The EN and A of the assert are routed to _compare_1.vhdl_, which uses them to latch the error permanently if one exists in any clock cycle. The same latching is also done to vhdl_assert_out.

_compare_1.vhdl_ then makes a top level assert to verify that the assert based latched error, and the VHDL bases latched error are indeed equal.

To add more cases, create files
- ex_3.vhdl
- ex_3.ys

and edit files
- compare_1.sh
- compare_1.vhdl

to take the ex_3 into use.
