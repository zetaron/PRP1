$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'days'



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

class DaysTest_num_sym < Test::Unit::TestCase

  RT = RuntimeError

  # Test (
  #   1 => true,
  #   2 => true,
  #   8 => false,
  #   'stuff' => ERR
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
 #   ('stuff') => ERR
 # )
 def test_day_sym?
   assert_equal(true, day_sym?(:MO))
   assert_equal(true, day_sym?(:DI))

   assert_equal(false, day_sym?(:TO))
   assert_equal(false, day_sym?('stuff'))
 end
end

class DaysTest_to < Test::Unit::TestCase

  RT = RuntimeError
  
  # Test (
  #   (1) => :MO,
  #   (7) => :SO,
  #   (:TO) => ERR,
  #   ('stuff') => ERR
  # )
  def test_day_num_to_day_sym
    assert_equal(:MO, day_num_to_day_sym(1))
    assert_equal(:SO, day_num_to_day_sym(7))

    assert_raise(RT) { day_num_to_day_sym(:TO) }
    assert_raise(RT) { day_num_to_day_sym('stuff') }
  end

  # Test (
  #   (:MO) => 1,
  #   (:SO) => 7,
  #   (3) => ERR,
  #   ('stuff') => ERR
  # )
  def test_day_sym_to_day_num
    assert_equal(1, day_sym_to_day_num(:MO))
    assert_equal(7, day_sym_to_day_num(:SO))

    assert_raise(RT) { day_sym_to_day_num(3) }
    assert_raise(RT) { day_sym_to_day_num('stuff') }
  end

  # Test (
  #   (1) => :MO,
  #   (:SO) => :SO,
  #   ('stuff') => ERR
  # )
  def test_to_day_sym
    assert_equal(:MO, to_day_sym(1))
    assert_equal(:SO, to_day_sym(:SO))

    assert_raise(RT) { to_day_sym('stuff') }
  end

  # Test (
  #   (1) => 1,
  #   (:SO) => 7,
  #   ('stuff') => ERR
  # )
  def test_to_day_num
    assert_equal(1, to_day_num(1))
    assert_equal(7, to_day_num(:SO))

    assert_raise(RT) { to_day_num('stuff') }
  end
end

class DaysTest_succ_pred < Test::Unit::TestCase

  RT = RuntimeError


  # Test (
  #   (1) => 2,
  #   (7) => 1,
  #   ('stuff') => ERR
  # )
  def test_day_num_succ
    assert_equal(2, day_num_succ(1))
    assert_equal(1, day_num_succ(7))

    assert_raise(RT) { day_num_succ('stuff') }
  end

  # Test (
  #   (1) => 7,
  #   (7) => 6,
  #   ('stuff') => ERR
  # )
  def test_day_num_pred
    assert_equal(7, day_num_pred(1))
    assert_equal(6, day_num_pred(7))

    assert_raise(RT) { day_num_pred('stuff') }
  end

   # Test (
  #   (:MO) => :DI,
  #   (:SO) => :MO,
  #   ('stuff') => ERR
  # )
  def test_day_sym_succ
    assert_equal(:DI, day_sym_succ(:MO))
    assert_equal(:MO, day_sym_succ(:SO))

    assert_raise(RT) { day_sym_succ('stuff') }
  end

  # Test (
  #   (:MO) => :SO,
  #   (:SO) => :SA,
  #   ('stuff') => ERR
  # )
  def test_day_sym_pred
    assert_equal(:SO, day_sym_pred(:MO))
    assert_equal(:SA, day_sym_pred(:SO))

    assert_raise(RT) { day_sym_pred('stuff') }
  end

 # Test (
  #   (1) => 2,
  #   (:MO) => :DI,
  #   ('stuff') => ERR
  # )
  def test_day_succ
    assert_equal(2, day_succ(1))
    assert_equal(:DI, day_succ(:MO))

    assert_raise(RT) { day_succ('stuff') }
  end

  # Test (
  #   (1) => 7,
  #   (:MO) => :SO,
  #   ('stuff') => ERR
  # )
  def test_day_pred
    assert_equal(7, day_pred(1))
    assert_equal(:SO, day_pred(:MO))

    assert_raise(RT) { day_pred('stuff') }
  end

end