 $LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
 require 'ext_pr1_v4'

 # min_int ::= int x int -> int
 #
 # Test (
 #      2 x 4 -> 2
 #      3 x 5 -> 3
 #      )

 def min_int(int1,int2)

   check_pre((
   (int1.int?) and
   (int2.int?)
   ))

   int1 < int2 ? int1 : int2   #condition ? true:false
 end

 #max_int ::= int x int -> int
 #
 # Test(
 #      2 x 4 -> 4
 #      3 x 5 -> 5
 #     )

 def max_int(int1,int2)

   check_pre((
   (int1.int?) and
   (int2.int?)
   ))

   int1 > int2 ? int1 : int2   #condition ? true:false
 end