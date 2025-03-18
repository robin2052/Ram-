module ram_tb;
  parameter width = 8, depth = 16;
  reg wrEn;  // When it will be high, we will be able to write data
  reg [width-1:0] wrData;  // The data to be written
  reg rdEn;  // Should be high to read the data
  reg [$clog2(depth)-1:0] wrAdress;  // Address where to write the data
  reg [$clog2(depth)-1:0] rdAdress;  // Address from where data will be read
  wire [width-1:0] rdData;
  reg clk;

  // Instantiate the DUT (Device Under Test)
  Ram dut(
    .wrEn(wrEn),
    .wrData(wrData), 
    .rdEn(rdEn),
    .wrAdress(wrAdress),
    .rdAdress(rdAdress),
    .rdData(rdData),
    .clk(clk)
  );
  
  // Clock generation
  initial clk = 0;
  always #10 clk = ~clk;  // Toggle clock every 10 time units
  integer i,j;
  // Testbench stimulus generation
  initial begin
    // Initialize signals
    wrEn <= 0;
    rdEn <= 0;
    wrAdress <= 0;
    rdAdress <= 0;
    wrData <= 0;
    
    // Loop for 10 write and read operations
    
    for (i = 0; i < 10; i = i + 1) begin
      @(posedge clk);  // Wait for rising edge of the clock
      wrEn <= 1;       // Enable write
      rdEn <= 0;       // Disable read
      wrAdress <= 4'd15-i;  // Random write address (0 to 15)
                // Random read address (0 to 15)
      wrData <= $urandom % 256;
    		// Random data to write (0 to 255)
      @(negedge clk);
      @(negedge clk);  // Wait for falling edge of the clock
      wrEn <= 0;       // Disable write
      rdEn <= 1;       // Enable read
       // Random write address (0 to 15)
      rdAdress <= 4'd15-i;  // Random read address (0 to 15)
        // Random data to write (0 to 255)
    end
  end 

  // Simulation stop after a fixed number of clock cycles
  initial begin
 
    for (j = 0; j < 20; j = j + 1) begin
      @(posedge clk);  // Wait for a rising edge of the clock
    end
    $finish;  // End simulation after 20 clock cycles
  end

endmodule
 