# Code
This folder contains all VHDL files

## Receiver
### [RX](RX.vhd)
RX file
- Input :
    - clk : clock
    - rst : reset
    - rx_in : RX input line (1 bit)
- Output : 
    - data_in : RX data (N  bits)
- Generic :
    - tiempo : period of RX signal
    - N : number of output data bits
    - rst_en : type of reset(high level by default)
### [RX_tb](RX_tb.vhd)
Testbench file for RX

### [TX](TX.vhd)
TX file
- Input :
    - clk : clock
    - rst : reset
    - data_out : TX data (N bits)
    - data_tx_ok :  TX's activation flag
- Output : 
    - tx_out : TX output liner (1  bit)
- Generic :
    - tiempo : period of RX signal
    - N : number of output data bits
    - rst_en : type of reset(high level by default)

### [TX_tb](TX_tb.vhd)
Testbench file for TX