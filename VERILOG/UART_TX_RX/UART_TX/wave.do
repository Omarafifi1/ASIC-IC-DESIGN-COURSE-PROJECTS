onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /UART_TOP_MODULE_TB/p_data_tb
add wave -noupdate /UART_TOP_MODULE_TB/clk_tb
add wave -noupdate /UART_TOP_MODULE_TB/rst_n_tb
add wave -noupdate /UART_TOP_MODULE_TB/data_valid_tb
add wave -noupdate /UART_TOP_MODULE_TB/parity_type_tb
add wave -noupdate /UART_TOP_MODULE_TB/parity_enable_tb
add wave -noupdate /UART_TOP_MODULE_TB/tx_out_tb
add wave -noupdate /UART_TOP_MODULE_TB/busy_tb
add wave -noupdate /UART_TOP_MODULE_TB/dut/uut0/current_state
add wave -noupdate /UART_TOP_MODULE_TB/dut/uut0/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {425308992 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 40
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 1
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {425293172 ps} {425321412 ps}
