$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
require 'ext_pr1_v4'

require "min_max"

# larger_sum_square :: Int x Int x Int :: (val1, val2, val3) ->? Int
#
# Test (
#   (2,1,5) => 29,
#   ('str', 1, 2) => Err
# )
def larger_sum_square(val1, val2, val3)
  square1 = max_int(val1, val2)**2
  square2 = max_int(min_int(val1, val2), val3)**2

  return square1 + square2
end

=begin
def larger_sum_square(val1, val2, val3)
  check_pre((
    (val1.int?) and
    (val2.int?) and
    (val3.int?)
  ))

  max = find_two_max_ints_from_aray([val1, val2, val3])
  max1 = max[0]
  max2 = max[1]

  square1 = max1**2
  square2 = max2**2

  return square1 + square2
end
=end

# find_two-max_int :: Array :: (vals) ->? Array
#
# Test (
#   ([2,1,5]) => [5,2],
#   ([99,30,2]) => [99,30],
#   (['str', 1, 2]) => Err,
#   ('str') => Err
# )
def find_two_max_ints_from_aray(vals)
  check_pre((
    (vals.array?) and
    (vals.all? { |val| val.int? })
  ))

  sorted = vals.sort

  return [sorted.pop(), sorted.pop()]
end