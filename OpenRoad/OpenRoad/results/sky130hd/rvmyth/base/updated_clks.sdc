###############################################################################
# Created by write_sdc
###############################################################################
current_design RV_CPU
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 4.8259 [get_ports {clk}]
set_clock_transition 0.4650 [get_clocks {clk}]
set_clock_uncertainty -setup 0.4650 clk
set_clock_uncertainty -hold 0.7440 clk
###############################################################################
# Environment
###############################################################################
set_input_transition 0.7440 [get_ports {reset}]
###############################################################################
# Design Rules
###############################################################################