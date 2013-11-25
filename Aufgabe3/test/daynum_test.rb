# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'daynum'

class DaynumTest < Test::Unit::TestCase
  
  RT = RuntimeError

  # Test (
  #   (DayNum[1], -2) => DayNum[6]
  # )
  def test_shift
    assert_equal(DayNum[6], DayNum[1].shift(-2))
  end

  # Test (
  #   DayNum[1].succ => DayNum[2]
  # )
  def test_succ
    assert_equal(DayNum[2], DayNum[1].succ)
  end

  # Test (
  #   DayNum[1].pred => DayNum[7]
  # )
  def test_pred
    assert_equal(DayNum[7], DayNum[1].pred)
  end

  def test_to_daysym
    assert_equal(DaySym[:MO], DayNum[1].to_daysym)
    assert_equal(DaySym[:SO], DayNum.new(7).to_daysym)
  end

  def test_to_sym
    assert_equal(:MO, DayNum[1].to_sym)
    assert_equal(:SO, DayNum.new(7).to_sym)
  end
end
