# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'day_sym'
require 'day_num'

class DaySymTest < Test::Unit::TestCase

  RT = RuntimeError
  AE = ArgumentError

  def test_equal
    assert_equal(true, DaySym[:MO] == DaySym[:MO])
    assert_equal(false, DaySym[:MO] == DaySym[:DI])
    assert_equal(false, DaySym[:DI] == DayNum[1])
  end

  def test_new
    assert_equal(DaySym[:MO], DaySym.new(:MO))

    assert_raise(AE) { DaySym.new(:LA) }
  end

  def test_shift
    assert_equal(DaySym[:SO], DaySym[:MO].shift(6))
    assert_equal(DaySym[:MO], DaySym[:MO].shift(7))
    assert_equal(DaySym[:DI], DaySym[:DI].shift(14))
    assert_equal(DaySym[:MI], DaySym[:DI].shift(15))

    assert_equal(DaySym[:MO], DaySym[:SO].shift(-6))
  end

  def test_succ
    assert_equal(DaySym[:DI], DaySym[:MO].succ)
    assert_equal(DaySym[:MO], DaySym[:SO].succ)
  end

  def test_pred
    assert_equal(DaySym[:MO], DaySym[:DI].pred)
    assert_equal(DaySym[:SO], DaySym[:MO].pred)
  end

  def test_to_index
    assert_equal(0, DaySym[:MO].to_index)
  end

  def test_from_index
    assert_equal(DaySym[:MO], DaySym.from_index(0))
  end

  def test_plus
    assert_equal(DaySym[:DO], DaySym[:MO] + 3)

    assert_equal(DaySym[:MO], DaySym[:DI] + 13)
  end

  def test_minus
    assert_equal(DaySym[:DO], DaySym[:MO] - 4)
  end

  def test_predicates
    assert_equal(false, DaySym[:MO].day_num?)
    assert_equal(true, DaySym[:MO].day?)
    assert_equal(true, DaySym[:MO].day_sym?)
  end

end
