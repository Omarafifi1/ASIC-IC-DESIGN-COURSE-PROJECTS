puts "****Assignment 2.0****"

set cities [list cairo alExandria damietta dakahlia faiyum sohag aswan]
puts $cities

set Cities_New ""

foreach x $cities {

set length [string length $x]
set upper [string toupper [string index $x 0]]
set lower [string tolower [string range $x 1 $length-1]]

set appendd [append upper $lower]
set Cities_New [lappend Cities_New $appendd]
}

puts $Cities_New

