# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'day_num'
require 'day_sym'

class DayNumTest < Test::Unit::TestCase

  RT = RuntimeError
  AE = ArgumentError

  def test_equal
    assert_equal(true, DayNum[1] == DayNum[1])
    assert_equal(false, DayNum[1] == DayNum[2])
    assert_equal(false, DayNum[2] == DaySym[:MO])
  end

  def test_new
    assert_equal(DayNum[1], DayNum.new(1))

    assert_raise(AE) { DayNum.new(8) }
  end

  def test_predicates
    assert_equal(true, DayNum[1].day_num?)
    assert_equal(true, DayNum[1].day?)
    assert_equal(false, DayNum[1].day_sym?)
  end

  def test_shift
    assert_equal(DayNum[7], DayNum[1].shift(6))
    assert_equal(DayNum[1], DayNum[1].shift(7))
    assert_equal(DayNum[2], DayNum[2].shift(14))
    assert_equal(DayNum[3], DayNum[2].shift(15))
    
    assert_equal(DayNum[1], DayNum[7].shift(-6))
  end

  def test_succ
    assert_equal(DayNum[2], DayNum[1].succ)
    assert_equal(DayNum[1], DayNum[7].succ)
  end

  def test_pred
    assert_equal(DayNum[1], DayNum[2].pred)
    assert_equal(DayNum[7], DayNum[1].pred)
  end

  def test_to_index
    assert_equal(0, DayNum[1].to_index)
  end

  def test_from_index
    assert_equal(DayNum[1], DayNum.from_index(0))
  end

  def test_plus
    assert_equal(DayNum[4], DayNum[1] + 3)
    
    assert_equal(DayNum[4], DayNum[6] + -2)
  end

  def test_minus
    assert_equal(DayNum[6], DayNum[1] - 2)

    assert_equal(DayNum[6], DayNum[4] - -2)
  end
  
end
