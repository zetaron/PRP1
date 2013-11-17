 $LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
 require 'ext_pr1_v4'
 require 'min_max'

 # larger_sum_square ::= Int x Int x Int -> Int
 #
 #
 #
 # Test (
 #      2 x 4 x 6 -> 4² + 6²  = 52
 #      3 x 5 x 7 -> 5² + 7²  = 74
 # )


def larger_sum_square(val1,val2,val3)
   square1 = max_int(val1,val2)**2
   square2 = max_int(min_int(val1,val2),val3)**2
   return square1+square2
 end