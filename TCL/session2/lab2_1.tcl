puts " **** Arrays & Procedures **** "

array set mohamed {wave 70 electronics 85 control 65 comm 78}
array set ahmed {wave 66 electronics 80 control 88 comm 69}
array set mostafa {wave 72 electronics 77 control 70 comm 88}

proc avg {arrayy} {
upvar $arrayy arr
set keys [array names arr]
set size [array size arr]
set y 0.0                     
#to get float set y 0.0
foreach x $keys {
set y [expr $y + $arr($x)]
}
return [expr $y/$size]
}

set Mohamed_GPA [avg mohamed]
set Ahmed_GPA [avg ahmed]
set Mostafa_GPA [avg mostafa]


puts "Mohamed Accumulative GPA is $Mohamed_GPA"
puts "Ahmed Accumulative GPA is $Ahmed_GPA"
puts "Mostafa Accumulative GPA is $Mostafa_GPA"