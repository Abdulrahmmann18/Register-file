module Reg_File_tb();

	// signals declaration
	reg CLK, RST, WrEn_tb, RdEn_tb;
	reg [2:0] Address_tb;
	reg [15:0] WrData_tb;
	wire [15:0] RdData_tb;

	// DUT Instantiation
	Reg_File RF1
	(
		.CLK(CLK),
		.RST(RST),
		.WrEn(WrEn_tb),
		.RdEn(RdEn_tb),
		.Address(Address_tb),
		.WrData(WrData_tb),
		.RdData(RdData_tb)
	);

	// clk generation block
	always begin
		#5 CLK = ~CLK;
	end

	// test stimulus
	initial begin
		// initialization
		CLK = 0;
		RST = 0;
		WrEn_tb = 0;
		RdEn_tb = 0;
		Address_tb = 3'b000;
		WrData_tb = 16'b1;
		#10
		RST = 1;
		// test write operation for two clock cycles
		WrEn_tb = 1;
		#10
		Address_tb = 3'b001;
		WrData_tb = 16'b10;
		// test read operation for two clock cycle
		#10
		WrEn_tb = 0;
		RdEn_tb = 1;
		Address_tb = 3'b000;
		#10
		Address_tb = 3'b001;
		// test no operation when RdEn and WrEn both are high
		#10
		WrEn_tb = 1;
		#30
		$stop;
	end

endmodule