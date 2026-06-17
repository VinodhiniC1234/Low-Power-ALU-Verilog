# Example FPGA Constraint File

# Operand A switches
set_property PACKAGE_PIN V17 [get_ports A[0]]

# Operand B switches
set_property PACKAGE_PIN W16 [get_ports B[0]]


# Enable signal
set_property PACKAGE_PIN U16 [get_ports enable]


# Result LED
set_property PACKAGE_PIN E19 [get_ports result[0]]
