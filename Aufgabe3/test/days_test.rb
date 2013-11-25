# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'days'

class DaysTest < Test::Unit::TestCase

  RT = RuntimeError
  
  # Test (
  #   (1) => true,
  #   (9) => false,
  #   ('str') => Err
  # )
  def test_day_num?
    assert_equal(true, day_num_elem?(1))
    assert_equal(false, day_num_elem?(9))

    assert_equal(false, day_num_elem?('str'))
  end

  # Test (
  #   (:MO) => true,
  #   (:LA) => false,
  #   ('str') => Err
  # )
  def test_day_sym?
    assert_equal(true, day_sym_elem?(:MO))
    assert_equal(false, day_sym_elem?(:LA))

    assert_equal(false, day_sym_elem?('str'))
  end

  # Test (
  #   (:MO) => true,
  #   (:LA) => false,
  #   (1) => true,
  #   (9) => false,
  #   ('str') => false
  # )
  def test_day?
    assert_equal(true, day?(:MO))
    assert_equal(false, day?(:LA))
    assert_equal(true, day?(1))
    assert_equal(false, day?(9))
    assert_equal(false, day?('str'))
  end

  # Test (
  #   (1) => :MO,
  #   (7) => :SO,
  #   (:MI) => Err,
  #   ('str') => Err
  # )
  def test_day_num_to_day_sym
    assert_equal(:MO, day_num_to_day_sym(1))
    assert_equal(:SO, day_num_to_day_sym(7))

    assert_raise(RT) { day_num_to_day_sym(:MI) }
    assert_raise(RT) { day_num_to_day_sym('str') }
  end

  # Test (
  #   (:MO) => 1,
  #   (:SO) => 7,
  #   (3) => Err,
  #   ('str') => Err
  # )
  def test_day_sym_to_day_num
    assert_equal(1, day_sym_to_day_num(:MO))
    assert_equal(7, day_sym_to_day_num(:SO))

    assert_raise(RT) { day_sym_to_day_num(3) }
    assert_raise(RT) { day_sym_to_day_num('str') }
  end

  # Test (
  #   (4) => :DO,
  #   (:FR) => :FR,
  #   ('SO') => Err (my raise)
  # )
  def test_to_day_sym
    assert_equal(:DO, to_day_sym(4))
    assert_equal(:FR, to_day_sym(:FR))

    assert_raise(RT) { to_day_sym('SO') }
  end

  # Test (
  #   (4) => 4,
  #   (:FR) => 5,
  #   ('SO') => Err (my raise)
  # )
  def test_to_day_num
    assert_equal(4, to_day_num(4))
    assert_equal(5, to_day_num(:FR))

    assert_raise(RT) { to_day_num('SO') }
  end

  # Test (
  #   (1) => 2,
  #   (7) => 1,
  #   ('str') => Err,
  #
  #   (1, 6) => 7,
  #   (1, 'str') => Err
  # )
  def test_day_num_succ
    assert_equal(2, day_num_succ(1))
    assert_equal(1, day_num_succ(7))

    assert_raise(RT) { day_num_succ('str') }

    assert_equal(7, day_num_succ(1, 6))

    assert_raise(RT) { day_num_succ(1, 'str') }
  end

  # Test (
  #   (1) => 7,
  #   (7) => 6,
  #   ('str') => Err,
  #
  #   (1, 6) => 2,
  #   (1, 'str') => Err
  # )
  def test_day_num_pred
    assert_equal(7, day_num_pred(1))
    assert_equal(6, day_num_pred(7))

    assert_raise(RT) { day_num_pred('str') }

    assert_equal(2, day_num_pred(1, 6))

    assert_raise(RT) { day_num_pred(1, 'str') }
  end

  # Test (
  #   (:MO) => :DI,
  #   (:SO) => :MO,
  #   ('str') => Err,
  #
  #   (:MO, 6) => :SO,
  #   (:MO, 'str') => Err
  # )
  def test_day_sym_succ
    assert_equal(:DI, day_sym_succ(:MO))
    assert_equal(:MO, day_sym_succ(:SO))

    assert_raise(RT) { day_sym_succ('str') }

    assert_equal(:SO, day_sym_succ(:MO, 6))
  end

  # Test (
  #   (:MO) => :SO,
  #   (:SO) => :SA,
  #   ('str') => Err,
  #
  #   (:MO, 6) => :DI,
  #   (:MO, 'str') => Err
  # )
  def test_day_sym_pred
    assert_equal(:SO, day_sym_pred(:MO))
    assert_equal(:SA, day_sym_pred(:SO))

    assert_raise(RT) { day_sym_pred('str') }

    assert_equal(:DI, day_sym_pred(:MO, 6))
  end

  # Test (
  #   (1) => 2,
  #   (:MO) => :DI,
  #   ('str') => Err,
  #
  #   (:MO, 6) => :SO,
  #   (1, 6) => 7
  # )
  def test_day_succ
    assert_equal(2, day_succ(1))
    assert_equal(:DI, day_succ(:MO))

    assert_raise(RT) { day_succ('str') }

    assert_equal(:SO, day_succ(:MO, 6))
    assert_equal(7, day_succ(1, 6))
  end

  # Test (
  #   (1) => 7,
  #   (:MO) => :SO,
  #   ('str') => Err,
  #
  #   (:MO, 6) => :DI,
  #   (1, 6) => 2
  # )
  def test_day_pred
    assert_equal(7, day_pred(1))
    assert_equal(:SO, day_pred(:MO))

    assert_raise(RT) { day_pred('str') }

    assert_equal(:DI, day_pred(:MO, 6))
    assert_equal(2, day_pred(1, 6))
  end
end
