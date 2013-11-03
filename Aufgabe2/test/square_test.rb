# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'square'

class SquareTest < Test::Unit::TestCase

  RT = RuntimeError

  # Test (
  #   (2,1,5) => 29,
  #   ('str', 1, 2) => Err
  # )
  def test_larger_sum_square
    assert_equal(29, larger_sum_square(2,1,5))

    assert_raise(RT) { larger_sum_square('str', 1, 2) }
  end

  # Test (
  #   ([2,1,5]) => [5,2],
  #   ([99,30,2]) => [99,30],
  #   (['str', 1, 2]) => Err,
  #   ('str') => Err
  # )
  def test_find_two_max_ints_from_array
    assert_equal([5,2], find_two_max_ints_from_aray([2,1,5]))
    assert_equal([99,30], find_two_max_ints_from_aray([99,30,2]))

    assert_raise(RT) { find_two_max_ints_from_aray(['str',1,2]) }
    assert_raise(RT) { find_two_max_ints_from_aray('str') }
  end
end
