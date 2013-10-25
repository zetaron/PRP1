# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'clock'

class ClockTest < Test::Unit::TestCase

  RT = RuntimeError

  # Test (
  #   ([1,30,10], [0,30,0]) => [2,0,10]
  #
  #   (1, [0,30,0]) => Err
  #   ([0,30,0], 1) => Err
  #
  #   (-1, [0,30,0]) => Err
  #   ([0,30,0], -1) => Err
  #
  #   ('1', [0,30,0]) => Err
  #   ([0,30,0], '1') => Err
  #
  #   ([1,30,10], [0,30,0], true) => [2,0,10,'AM']
  #   ([1,30,10], [0,30,0], false) => [2,0,10,'PM']
  #   ([22,30,10], [0,30,0], false) => [23,0,10,'PM']
  #   ([1,30,10], [0,30,0], 'false') => Err
  # )
  def test_add_timearray_to_timearray
    current_time = [1,30,10]
    additional_time = [0,30,0]
    current_time_am = [1,30,10,'AM']
    current_time_pm = [1,30,10,'PM']
    
    assert_equal([2,0,10], add_timearray_to_timearray(current_time, additional_time))

    assert_raise(RT) { add_timearray_to_timearray(1, additional_time) }
    assert_raise(RT) { add_timearray_to_timearray(current_time, 1) }

    assert_raise(RT) { add_timearray_to_timearray(-1, additional_time) }
    assert_raise(RT) { add_timearray_to_timearray(current_time, -1) }

    assert_raise(RT) { add_timearray_to_timearray('1', additional_time) }
    assert_raise(RT) { add_timearray_to_timearray(current_time, '1') }

    assert_equal([2,0,10,'AM'], add_timearray_to_timearray(current_time_am, additional_time, true))
    assert_equal([2,0,10,'PM'], add_timearray_to_timearray(current_time_pm, additional_time, true))
    assert_not_equal([2,0,10,'PM'], add_timearray_to_timearray(current_time, additional_time, false))

    assert_raise(RT) { add_timearray_to_timearray(current_time, additional_time, 'false') }
  end

  # Test (
  #   (1,30,10) => 5410,
  #
  #   (-1,30,10) => Err,
  #   (1,-30,10) => Err,
  #   (1,30,-10) => Err,
  #
  #   ('1',30,10) => Err,
  #   (1,'30',10) => Err,
  #   (1,30,'10') => Err
  # )
  def test_time_to_sec()
    assert_equal(5410, time_to_seconds(1, 30, 10))

    assert_raise(RT) { time_to_seconds(-1, 30, 10) }
    assert_raise(RT) { time_to_seconds(1, -30, 10) }
    assert_raise(RT) { time_to_seconds(1, 30, -10) }

    assert_raise(RT) { time_to_seconds('1', 30, 10) }
    assert_raise(RT) { time_to_seconds(1, '30', 10) }
    assert_raise(RT) { time_to_seconds(1, 30, '10') }
  end

  # Test (
  #   (5410) => [1,30,10],
  #
  #   (-1) => Err,
  #   ('1') => Err
  # )
  def test_seconds_to_timearray()
    assert_equal([1,30,10], seconds_to_timearray(5410))

    assert_raises(RT) { seconds_to_timearray(-1) }

    assert_raises(RT) { seconds_to_timearray('1') }
  end

  # Test (
  #   ([23,30,20]) => [11,30,20,'PM'],
  #   ([11,30,20]) => [11,30,20,'AM'],
  #   ('string') => Err,
  #   (-123) => Err
  # )
  def test_time_to_analogtime
    assert_equal([11,30,20,'PM'], time_to_analogtime([23,30,20]))
    assert_equal([11,30,20,'AM'], time_to_analogtime([11,30,20]))

    assert_raise(RT) { time_to_analogtime('string') }
    assert_raise(RT) { time_to_analogtime(-123) }
  end

  # Test (
  #   ([11,30,40,'AM']) => [11,30,40],
  #   ([11,30,40,'PM']) => [23,30,40],
  #   ([11,30,40]) => Err,
  #   ('string') => Err,
  # )
  def test_analogtime_to_time
    assert_equal([11,30,40], analogtime_to_time([11,30,40,'AM']))
    assert_equal([23,30,40], analogtime_to_time([11,30,40,'PM']))

    assert_raise(RT) { analogtime_to_time([11,30,40]) }
    assert_raise(RT) { analogtime_to_time('string') }
  end
end

