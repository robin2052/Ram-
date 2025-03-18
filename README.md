# Ram-
The Ram module is a parameterized synchronous RAM (Random Access Memory) designed in Verilog. It features:

Parameters:
width (default: 8 bits) defines the data width of each memory location.
depth (default: 16) specifies the number of addressable memory locations.
Inputs:
clk: Clock signal for synchronous operations.
wrEn: Write enable signal (active high to write data).
wrData [width-1:0]: Data input to be written to memory.
rdEn: Read enable signal (active high to read data).
wrAdress [$clog2(depth)-1:0]: Write address, dynamically sized based on depth.
rdAdress [$clog2(depth)-1:0]: Read address, dynamically sized based on depth.
Output:
rdData [width-1:0]: Data output read from the specified address.
Functionality:
Uses a register array mem [depth-1:0] to store data.
On the positive clock edge, if wrEn is high, data from wrData is written to the location specified by wrAdress.
If rdEn is high, data from the location specified by rdAdress is output to rdData.
Purpose: This module can serve as a building block for memory-intensive designs, such as FIFOs or data buffers.
ram_tb Testbench
The ram_tb is a Verilog testbench designed to verify the functionality of the Ram module. Key features include:

Instantiation: Instantiates the Ram module (DUT) with default parameters (width = 8, depth = 16).
Clock Generation: Generates a clock signal toggling every 10 time units.
Stimulus:
Performs 10 write and read operations using a loop.
Generates random 8-bit data using $urandom % 256 for wrData.
Uses descending addresses (15-i) for wrAdress and rdAdress to test memory locations.
Alternates between write (wrEn = 1) and read (rdEn = 1) phases on clock edges.
Simulation Control:
Runs for 20 clock cycles before terminating with $finish.
Purpose: Tests the RAM’s ability to write and read data correctly across different addresses, providing a basic validation of the module’s behavior under controlled random input.
Usage
Simulate the testbench using a Verilog simulator (e.g., ModelSim, VCS) to observe the RAM’s response.
Modify parameters (width, depth) or stimulus patterns to test different configurations or edge cases.
