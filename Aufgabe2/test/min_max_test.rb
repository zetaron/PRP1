# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'min_max'

class MinMaxTest < Test::Unit::TestCase
  RT = RuntimeError

  # Test (
  #   (1,2) => 1,
  #   (2,1) => 1,
  #   ('str', true) => Err
  # )
  def test_min_int
    assert_equal(1, min_int(1,2))
    assert_equal(1, min_int(2,1))

    assert_raise(RT) { min_int('str', true) }
  end

  # Test (
  #   (1,2) => 2,
  #   (2,1) => 2,
  #   ('str', true) => Err
  # )
  def test_max_int
    assert_equal(2, max_int(1,2))
    assert_equal(2, max_int(2,1))

    assert_raise(RT) { max_int('str', true) }
  end

  # Test (
  #   (1,0,4) => true,
  #   (1,2,4) => false,
  #   ('lol', 'lal', 'lul') => Err
  # )
  def test_within?
    assert_equal(true, within?(1,0,4))
    assert_equal(false, within?(1,2,4))

    assert_raise(RT) { within?('lol', 'lal', 'lul') }
  end
end
