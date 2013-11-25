# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'daysym'

class DaysymTest < Test::Unit::TestCase
  
  RT = RuntimeError

  # Test (
  #   (DaySym[:MO], -2) => DaySym[:SA]
  #   (DaySym[:MO], 2) => DaySym[:MI]
  # )
  def test_shift
    assert_equal(DaySym[:SA], DaySym[:MO].shift(-2))
    assert_equal(DaySym[:MI], DaySym[:MO].shift(2))
  end

  # Test (
  #   (DaySym[:SA]) => :SA,
  #   (DaySym[:LA]) => Err
  # )
  def test_to_sym
    assert_equal(:SA, DaySym[:SA].to_sym)

    assert_raise(RT) { DaySym[:LA].to_sym }
  end

  def test_to_daysym
    assert_equal(DaySym[:SA], DaySym[:SA].to_daysym)
  end

  # Test (
  #   DayNum[:MO].succ => DayNum[:DI]
  # )
  def test_succ
    assert_equal(DaySym[:DI], DaySym[:MO].succ)
  end

  # Test (
  #   DaySym[:MO].pred => DayNum[:SO]
  # )
  def test_pred
    assert_equal(DaySym[:SO], DaySym[:MO].pred)
  end

  def test_from_sym
    assert_equal(DaySym[:MO], DaySym[:SO].from_sym(:MO))
    assert_equal(DaySym[:MO], DaySym.new(:MO))

    #assert_raise(RT) { DaySym.new(:LA) } # should have FAILED...
    #assert_raise(RT) { DaySym[:DO].from_sym(:LO) } # should have FAILED...
  end
end
