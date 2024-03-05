puts "**** List Operations Lab ****"

set lst0 [list Jan Mar April May]
set lst1 {June July August}

puts $lst0
puts $lst1

puts "length of lsto:[llength $lst0]"
puts "third item of lst1:[lindex $lst1 2]"

if {[lsearch $lst1 Oct]==-1} {
puts "oct is not existed in the list"
} else {
puts "oct existed in the list"
}

puts [linsert $lst0 1 Feb]
puts [lappend lst1 Sep Oct Nov Dec]

set list2 [concat $lst0 $lst1]

puts [lrange $list2 0 [expr [llength $list2]-1 ]]
puts [join $list2 ", "]

for {set index 0} {$index < [llength $lst0]} {incr index} {
puts [string toupper [lindex $lst0 $index]]
}

foreach x $lst1 {
puts [string tolower $x] 
}
