puts "****Writing Verilog Block Interface****"
set modname "Up_Dn_Counter"
set in_ports [list IN Load Up Down CLK]
set in_ports_width [list 4 1 1 1 1]

set out_ports [list High Counter Low]
set out_ports_width [list 1 4 1]

set file_data "module $modname ("

foreach x $in_ports {
set file_data [lappend file_data input "$x,"]
}



foreach y $out_ports {
set file_data [lappend file_data output "$y,"]
}

set file_data [lappend file_data ","]
puts $file_data
set a 0
while {$a<[llength $file_data]} {
puts "[lrange $file_data $a $a+1 ]\n"
incr a
incr a
}


set in_index [lsearch $file_data IN,]
set out_index [lsearch $file_data Counter,]

set file_data [linsert $file_data $in_index {3:0}]
set file_data [linsert $file_data $out_index+1 {3:0}]
















