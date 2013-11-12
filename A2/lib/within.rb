 $LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
 require 'ext_pr1_v4'

 # within? ::= nat x nat x nat -> bool
 #
 # Test (
 #      2 x 4 x 6 -> false
 #      5 x 3 x 7 -> true
 #      )

 def within?(val,lower,upper)

   check_pre((
   (val.nat?) and
   (lower.nat?) and
   (upper.nat?)
   ))

   (val >= lower) and (val <= upper)

 end