puts "string manipulation lab"
set str1 "mahmoudahmed@gmail.com"
set str2 "mostafali@hotmail.com"
puts "the length of str1 is [string length $str1]"
set index [string first @ $str1]
set upper [string toupper [string range $str1 0 $index-1 ]]
puts "str1 Email Name is $upper"
set index1 [string first @ $str2]
set index2 [string first . $str2]
set domain [string range $str2 $index1+1 $index2-1]
puts "Domain Name of str2 is $domain"
set new [string tolower $upper]
append newdomain $new {@hotmail.com}
puts "the new mail address is $newdomain"
if {[string first gmail $str1]} { ## or [string match *gmail* $str1]
puts "it is a gmail account"
} else {
puts "it is not a gmail account"
}