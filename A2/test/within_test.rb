# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'within'

 # within? ::= nat x nat x nat -> bool
 #
 # Test (
 #      2 x 4 x 6 -> false
 #      5 x 3 x 7 -> true
 #      )

class WithinTest < Test::Unit::TestCase

  RT = RuntimeError

  def test_within
    assert_equal(true,  within?(5,3,7))
    assert_equal(false, within?(2,4,6))

    assert_raise(RT) {within?(-2,4,6)}
    assert_raise(RT) {within?(2,-4,6)}
    assert_raise(RT) {within?(2,4,-6)}

  end
end
