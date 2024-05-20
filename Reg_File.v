module Reg_File 
(
	input wire 		  CLK,
	input wire 		  RST,
	input wire 		  WrEn,
	input wire 		  RdEn,
	input wire [2:0]  Address,
	input wire [15:0] WrData,
	output reg [15:0] RdData
);
	
	reg [15:0] R_FILE [0:7];

	always @(posedge CLK or negedge RST) begin
		if (~RST) begin
			R_FILE[0] <= 16'b0;
			R_FILE[1] <= 16'b0;
			R_FILE[2] <= 16'b0;
			R_FILE[3] <= 16'b0;
			R_FILE[4] <= 16'b0;
			R_FILE[5] <= 16'b0;
			R_FILE[6] <= 16'b0;
			R_FILE[7] <= 16'b0;
			RdData <= 16'b0;
		end
		else begin
			case ({WrEn, RdEn})
				2'b01 :
				begin
					RdData <= R_FILE[Address];
				end
				2'b10 :
				begin
					R_FILE[Address] <= WrData;	
				end
				default :
				begin
					R_FILE[Address] <= R_FILE[Address];
					RdData <= RdData;
				end

			endcase
		end
	end




endmodule