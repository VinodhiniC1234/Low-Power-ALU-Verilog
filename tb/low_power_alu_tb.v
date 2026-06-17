//====================================================
// Low Power ALU Testbench
//====================================================

`timescale 1ns/1ps

module low_power_alu_tb;

parameter WIDTH = 8;


// Inputs
reg [WIDTH-1:0] A;
reg [WIDTH-1:0] B;
reg [3:0] opcode;
reg enable;


// Outputs
wire [WIDTH-1:0] result;
wire zero_flag;
wire carry_flag;
wire overflow_flag;
wire negative_flag;


// Waveform generation

initial
begin
    $dumpfile("dump.vcd");
    $dumpvars(0, low_power_alu_tb);
end



// ALU Instance

low_power_alu #(WIDTH) DUT
(
    .A(A),
    .B(B),
    .opcode(opcode),
    .enable(enable),

    .result(result),

    .zero_flag(zero_flag),
    .carry_flag(carry_flag),
    .overflow_flag(overflow_flag),
    .negative_flag(negative_flag)
);



initial
begin

$display("--------------------------------");
$display("LOW POWER ALU VERIFICATION");
$display("--------------------------------");


$monitor(
"Time=%0t | A=%d B=%d | Opcode=%b | Result=%d | Z=%b C=%b O=%b N=%b",
$time,
A,
B,
opcode,
result,
zero_flag,
carry_flag,
overflow_flag,
negative_flag
);


// Enable ALU

enable = 1;



// ADD Test

A = 8'd10;
B = 8'd5;
opcode = 4'b0000;

#10;


// SUB Test

A = 8'd20;
B = 8'd8;
opcode = 4'b0001;

#10;


// AND Test

A = 8'b11110000;
B = 8'b00001111;
opcode = 4'b0010;

#10;


// OR Test

opcode = 4'b0011;

#10;


// XOR Test

opcode = 4'b0100;

#10;


// NOT A Test

A = 8'b10101010;
opcode = 4'b0101;

#10;


// SHIFT LEFT

A = 8'b00001111;
opcode = 4'b0110;

#10;


// SHIFT RIGHT

A = 8'b11110000;
opcode = 4'b0111;

#10;


// Increment

A = 8'd25;
opcode = 4'b1000;

#10;


// Decrement

A = 8'd25;
opcode = 4'b1001;

#10;


// Compare A>B

A = 8'd30;
B = 8'd10;
opcode = 4'b1010;

#10;


// Compare A<B

A = 8'd5;
B = 8'd20;
opcode = 4'b1010;

#10;


// Compare Equal

A = 8'd15;
B = 8'd15;
opcode = 4'b1010;

#10;


// Disable ALU (Low Power Mode)

enable = 0;

A = 8'd100;
B = 8'd50;
opcode = 4'b0000;

#10;



$display("--------------------------------");
$display("SIMULATION COMPLETED SUCCESSFULLY");
$display("--------------------------------");


$finish;


end


endmodule