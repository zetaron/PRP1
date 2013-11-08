$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
require 'ext_pr1_v4'

# min_int :: Int x Int :: (val1, val2) ->? Int
# 
# Test (
#   (1,2) => 1,
#   (2,1) => 1,
#   ('str', true) => Err
# )
def min_int(val1, val2)
  check_pre((
      (val1.int?) and
      (val2.int?)
  ))

  val1 < val2 ? val1 :val2
end

# max_int :: Int x Int :: (val1, val2) ->? Int
#
# Test (
#   (1,2) => 2,
#   (2,1) => 2,
#   ('str', true) => Err
# )
def max_int(val1, val2)
  check_pre((
      (val1.int?) and
      (val2.int?)
  ))

  val1 > val2 ? val1 : val2
end

# within? :: Int x Int x Int :: (val, lower, upper) ->? Bool
#
# Test (
#   (1,0,4) => true,
#   (1,2,4) => false,
#   ('lol', 'lal', 'lul') => Err
# )
def within?(val, lower, upper)
  check_pre((
      (val.int?) and
      (lower.int?) and
      (upper.int?)
  ))

  ((val >= lower) and (val <= upper))
end