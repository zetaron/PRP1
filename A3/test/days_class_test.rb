$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'days_class'

class DaysClassTest < Test::Unit::TestCase

  RT = RuntimeError

  # Test (
  #   1 => true,
  #   2 => true,
  #   8 => false,
  #   'stuff' => ERR
  # )
  def test_class_daynum
    assert_equal(true, DayNum[1].day_num?)
    assert_equal(true, DayNum[2].day_num?)

    assert_raise(RT)   {DayNum[8].day_num?}
    assert_equal(false, 'stuff'.day_num?)
  end

  # Test (
  #   (:MO) => true,
  #   (:Di) => true,
  #   (:TO) => false,
  #   ('stuff') => ERR
  # )
  def test_class_daysym
   assert_equal(true, DaySym[:MO].day_sym?)
   assert_equal(true, DaySym[:DI].day_sym?)
   

   assert_raise(RT)   {DaySym[:TO].day_sym?}
   assert_equal(false, 'stuff'.day_sym?)
  end

  # Test (
  # 1 => true
  # (:MO) => true
  # 8 => false
  # (:TO) => false
  # ('stuff') => ERR 
  # )
  def test_day
   assert_equal(true, DayNum[1].day_num?)
   assert_equal(true, DaySym[:MO].day_sym?)

   assert_raise(RT)   {DayNum[8].day_num?}
   assert_raise(RT)   {DaySym[:TO].day_num?}

   assert_equal(false, 'stuff'.day_sym?)
   assert_equal(false, 'stuff'.day_num?)
  end

end
