# 5 Stage Pipelined MIPS Datapath

## About
Repository to store ECE369 final project. This datapath was implemented using Verilog code, synthesized in Vivado, and ran on a xilinx FPGA board. We used hazard detection to delay the pipeline as well as forward dependant values. This datapath was designed to run a Sum of Absolute Differences (SAD) algorithm which determines the similarity of image blocks. The algorithm outputs the coordinates of the image block with closest similarity to the input block.

## Datapath
Here is our datapath diagram:

![Datapath](/datapath.jpeg)
