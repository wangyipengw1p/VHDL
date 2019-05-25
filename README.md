# VHDL
A collection of useful entities in VHDL. 

```DQPSK``` and ```OFDM``` are copied and  modified from opencores. 

Most of them are spin-offs from my projects, and simulated or implemented on FPGA. Some of them were written when I was a beginer of VHDL and not well designed. Also, I'm still learning digital design, so please don't hesitate to till me the problem in design or your better ideas:) 
Thanks in advance.

## Entity lists
- #### Binary_to_BCD: From 8 bits binary to 10bits BCD code. For examples and demo of the algorithm, please look at [this web](http://www.johnloomis.org/ece314/notes/devices/binary_to_BCD/bin_to_bcd.html).
- #### Binary_to_Gery
- #### Binary_to_seven_segment
- #### Blink_helloworld: Hello world in digital world --- Blinking the LED :)  Used to test new board or design environment.
- #### clkdiv_odd: Genaric odd clk divider. 
- #### CORDIC: Useful for othodogrnal-polar conversion, calculating ```tan```  ```sin``` ```cos``` and natural logarithm```e```. 
- #### DQPSK(from opencore)
- #### FIFO
- #### FSM_sequence_detector: Basic FSM.
- #### I2C: I2C interface.
- #### MOD3: Combinational mod3.
- #### OFDM(from opencore)
- #### package
- #### PS2_keyboard: PS2_keyboard input and display. See doc for more info
- #### PSK: Digital generated PSK modulated wave. First receieve, check the odd-even check point. Then transimite.
- #### VGA: hs vs signal genetrator for VGA.

## REF 
Some useful book and resources for learning VHDL.

## Testbench
Some useful memo for writing tb.

## Useful links for learning VHDL
- [Tutorial Examples for beginers](https://www.csee.umbc.edu/portal/help/VHDL/samples/samples.shtml).
- [HTML Version of IEEE Libraries](https://www.cs.sfu.ca/~ggbaker/reference/std_logic/).
- [Official Cite](https://www.doulos.com/knowhow/vhdl_designers_guide/)
- [VHDL archive from Hamburg University](https://tams-www.informatik.uni-hamburg.de/vhdl/vhdl.html) and it's [VHDL cookbook](https://tams-www.informatik.uni-hamburg.de/vhdl/doc/cookbook/VHDL-Cookbook.pdf).
- [VHDL syntext](https://www.csee.umbc.edu/portal/help/VHDL/design.html)
- [Learning FPGA](https://www.fpga4fun.com/HDLtutorials.html) ```very comprehensive```