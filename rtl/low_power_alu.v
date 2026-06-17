//====================================================
// Low Power ALU Design using Verilog
// 8-bit Parameterized ALU
// Operand Isolation based Low Power Concept
//====================================================

module low_power_alu #(
    parameter WIDTH = 8
)
(
    input  [WIDTH-1:0] A,
    input  [WIDTH-1:0] B,
    input  [3:0] opcode,
    input enable,

    output reg [WIDTH-1:0] result,

    output reg zero_flag,
    output reg carry_flag,
    output reg overflow_flag,
    output reg negative_flag
);


// Temporary variable
reg [WIDTH:0] temp;


// ALU Operation

always @(*)
begin

    // Default values
    result = 0;
    carry_flag = 0;
    overflow_flag = 0;


    // Low Power Operand Isolation
    // When enable = 0, computation stops

    if(enable)
    begin

        case(opcode)

        4'b0000:        // ADD
        begin
            temp = A + B;
            result = temp[WIDTH-1:0];
            carry_flag = temp[WIDTH];
        end


        4'b0001:        // SUB
        begin
            result = A - B;
        end


        4'b0010:        // AND
        begin
            result = A & B;
        end


        4'b0011:        // OR
        begin
            result = A | B;
        end


        4'b0100:        // XOR
        begin
            result = A ^ B;
        end


        4'b0101:        // NOT A
        begin
            result = ~A;
        end


        4'b0110:        // Shift Left
        begin
            result = A << 1;
        end


        4'b0111:        // Shift Right
        begin
            result = A >> 1;
        end


        4'b1000:        // Increment
        begin
            result = A + 1;
        end


        4'b1001:        // Decrement
        begin
            result = A - 1;
        end


        4'b1010:        // Compare
        begin

            if(A>B)
                result = 8'b00000001;

            else if(A<B)
                result = 8'b00000010;

            else
                result = 8'b00000000;

        end


        default:
        begin
            result = 0;
        end


        endcase

    end

    else
    begin
        result = 0;
    end



    // Flag Generation

    zero_flag = (result == 0);

    negative_flag = result[WIDTH-1];



    // Overflow detection

    if(opcode == 4'b0000)
        overflow_flag = 
        (~(A[7]^B[7])) & (result[7]^A[7]);

    else if(opcode == 4'b0001)
        overflow_flag =
        ((A[7]^B[7])) & (result[7]^A[7]);

    else
        overflow_flag = 0;


end

endmodule