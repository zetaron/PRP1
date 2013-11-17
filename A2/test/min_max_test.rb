# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'min_max'

 # min_int ::= int x int -> int
 #
 # Test (
 #      2 x 4 -> 2
 #      3 x 5 -> 3
 #      )


 #max_int ::= int x int -> int
 #
 # Test(
 #      2 x 4 -> 4
 #      3 x 5 -> 5
 #      )

class MinMaxTest < Test::Unit::TestCase

  RT = RuntimeError

  def test_min_int
    assert_equal(2,   min_int(2,4))
    assert_equal(3,   min_int(3,5))
    assert_equal(-4,  min_int(2,-4))
    assert_equal(-2,  min_int(-2,4))

    assert_raise(RT)  {min_int('string',4)}
    assert_raise(RT)  {min_int(2,'string')}
    
  end
    
  def test_max_int
    assert_equal(4,   max_int(2,4))
    assert_equal(5,   max_int(3,5))
    assert_equal(4,   max_int(-2,4))
    assert_equal(2,   max_int(2,-4))

    assert_raise(RT)  {max_int('string',4)}
    assert_raise(RT)  {max_int(2,'string')}

  end
end
