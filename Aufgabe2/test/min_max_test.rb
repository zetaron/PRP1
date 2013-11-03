# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'min_max'

class MinMaxTest < Test::Unit::TestCase
  RT = RuntimeError

  def test_min
    assert_equal(1, min_int(1,2))
    assert_equal(1, min_int(2,1))

    assert_raise(RT) { min_int('str', true) }
  end

  def test_max
    assert_equal(2, max_int(1,2))
    assert_equal(2, max_int(2,1))

    assert_raise(RT) { max_int('str', true) }
  end

  def test_within?
    assert_equal(true, within?(1,0,4))
    assert_equal(false, within?(1,2,4))

    assert_raise(RT) { within?('lol', 'lal', 'lul') }
  end
end
