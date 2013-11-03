# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'temperature'

class TemperatureTest < Test::Unit::TestCase
  RT = RuntimeError

  # Test (
  #   (40) => false,
  #   (14) => true,
  #   (true) => Err,
  #   ('str') => Err
  # )
  def test_zu_kalt?
    assert_equal(true, zu_kalt?(14))
    assert_equal(false, zu_kalt?(18))

    assert_raise(RT) { zu_kalt?(true) }
    assert_raise(RT) { zu_kalt?('str') }
  end

  # Test (
  #   (40) => true,
  #   (14) => false,
  #   (true) => Err,
  #   ('str') => Err
  # )
  def test_zu_warm?
    assert_equal(true, zu_warm?(40))
    assert_equal(false, zu_warm?(14))

    assert_raise(RT) { zu_warm?(true) }
    assert_raise(RT) { zu_warm?('str') }
  end

  # Test (
  #   (16) => true,
  #   (22) => true,
  #   (40) => false,
  #   (2) => false
  # )
  def test_angenehm?
    assert_equal(true, angenehm?(16))
    assert_equal(true, angenehm?(22))
    assert_equal(false, angenehm?(40))
    assert_equal(false, angenehm?(2))
  end

  # Test (
  #   (16) => false,
  #   (22) => false,
  #   (40) => true,
  #   (2) => true
  # )
  def test_unangenehm?
    assert_equal(false, unangenehm?(16))
    assert_equal(false, unangenehm?(22))
    assert_equal(true, unangenehm?(40))
    assert_equal(true, unangenehm?(2))
  end
end
