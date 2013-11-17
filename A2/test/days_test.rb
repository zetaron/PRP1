# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'days'



class DaysTest_num_sym < Test::Unit::TestCase

  RT = RuntimeError

  # Test (
  #   1 => true,
  #   2 => true,
  #   8 => false,
  #   'stuff' => false
  # )
  def test_day_num?
    assert_equal(true, day_num?(1))
    assert_equal(true, day_num?(2))

    assert_equal(false, day_num?(8))
    assert_equal(false, day_num?('stuff'))
  end

 # Test (
 #   (:MO) => true,
 #   (:Di) => true,
 #   (:TO) => false,
 #   ('stuff') => false
 # )
 def test_day_sym?
   assert_equal(true, day_sym?(:MO))
   assert_equal(true, day_sym?(:DI))

   assert_equal(false, day_sym?(:TO))
   assert_equal(false, day_sym?('stuff'))
 end
end

class DaysTest < Test::Unit::TestCase

  RT = RuntimeError

  # Test (
  #   (:MO) => true,
  #   (:DI) => true,
  #   (:TO) => false,
  #   (1) => true,
  #   (8) => false,
  #   ('stuff') => false
  # )
  def test_day?
    assert_equal(true,  day?(:MO))
    assert_equal(true,  day?(:DI))
    assert_equal(false, day?(:TO))
    assert_equal(true,  day?(1))
    assert_equal(false, day?(8))
    assert_equal(false, day?('stuff'))
  end
end


