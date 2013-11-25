# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'larger_sum_square'

class LargerSumSquareTest < Test::Unit::TestCase
# larger_sum_square ::= int x int x int -> int
 #
 # Test (
 #      2 x 4 x 6 -> 4² + 6²  = 52
 #      3 x 5 x 7 -> 5² + 7²  = 74
 #      )

  RT = RuntimeError

  def test_larger_sum_square
    assert_equal((4**2+6**2),   larger_sum_square(2,4,6))
    assert_equal((4**2+2**2),   larger_sum_square(2,4,-6))
    assert_equal((5**2+7**2),   larger_sum_square(3,5,7))
    assert_equal((5**2+3**2),   larger_sum_square(3,5,-7))


    assert_raise(RT)  {larger_sum_square('string',4,6)}
    assert_raise(RT)  {larger_sum_square(2,'string',6)}
    assert_raise(RT)  {larger_sum_square(2,4,'string')}

  end
end
