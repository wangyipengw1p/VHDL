# VHDL examples
A collection of useful entities in VHDL. 

If you are looking for examples for beginers, then please refer to the tutorial linked [here]( https://github.com/wangyipengw1p/VHDL/blob/master/README.md#useful-links-for-learning-vhdl). 

elsif you want more advanced design,then please refer to [here](https://github.com/xesscorp/VHDL_Lib).

end if;

```Warning: Referring Latch ...``` 

<br>
Most of the entities are spin-offs from my projects, and simulated or implemented on FPGA. Some of them were written when I was a beginer of VHDL and were not well designed. Since I'm still learning digital design, please don't hesitate to tell me the problem in design or your better ideas:) 
Thanks in advance.

Note that ```DQPSK``` and ```OFDM``` are copied and  modified from [opencores](https://opencores.org). 
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

## _REF 
Some useful book and resources for learning VHDL.



## Useful links for learning VHDL
- [Tutorial Examples for beginers, UMBC](https://www.csee.umbc.edu/portal/help/VHDL/samples/samples.shtml).
- [More structured tutorial for beginers, UCR](http://esd.cs.ucr.edu/labs/tutorial/)
- [HTML Version of IEEE Libraries](https://www.cs.sfu.ca/~ggbaker/reference/std_logic/).
- [HTML Version of IEEE Libraries2](https://www.csee.umbc.edu/portal/help/VHDL/stdpkg.html)
- [Official Cite](https://www.doulos.com/knowhow/vhdl_designers_guide/)
- [VHDL archive from Hamburg University](https://tams-www.informatik.uni-hamburg.de/vhdl/vhdl.html) and it's [VHDL cookbook](https://tams-www.informatik.uni-hamburg.de/vhdl/doc/cookbook/VHDL-Cookbook.pdf).
- [VHDL syntext](https://www.csee.umbc.edu/portal/help/VHDL/design.html)
- [Learning FPGA](https://www.fpga4fun.com/HDLtutorials.html) ```very comprehensive```
- [VLSI design](https://www.tutorialspoint.com/vlsi_design/index.htm)

## VHDL or Verilog?

Here are two articles comparing VHDL and Verilog [1-PDF](https://github.com/wangyipengw1p/VHDL/blob/master/_REF/vhdl_verilog_compared.pdf) (official paper) [2-HTML](http://www.angelfire.com/in/rajesh52/verilogvhdl.html)(compared with C) comprehensively.

Hope it helps!
