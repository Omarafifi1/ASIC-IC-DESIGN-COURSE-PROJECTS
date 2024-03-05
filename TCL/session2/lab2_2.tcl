puts "**** File I/O & Regsub Lab****"

set fh [open Interfacee.txt r+]
set file_data [read $fh]

puts $file_data

regsub -all "input" $file_data "reg" file_data
regsub -all "output" $file_data "wire" file_data


set in_list [list IN Load Up Down CLK]
set out_list [list High Counter Low]

foreach x $in_list {
regsub  "$x" $file_data "i_$x;" file_data
}

foreach y $out_list {
regsub  "$y" $file_data "o_$y;" file_data
}

puts $file_data

set fh1 [open tb.txt w+]
puts $fh1 $file_data

close $fh1
close $fh