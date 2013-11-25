# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'temperature'

 # Test (
 # zu_kalt?
 #      1  -> true
 #      16 -> false
 #
 # zu_warm?
 #      23 -> true
 #      22 -> false
 #
 # angenehm?
 #      16 -> true
 #      22 -> true
 #      15 -> false
 #      23 -> false
 #
 # unangenehm?
 #      16 -> false
 #      22 -> false
 #      15 -> true
 #      23 -> true
 # )

class TemperaturTest < Test::Unit::TestCase
  
  RT = RuntimeError

  def test_zu_kalt?
    assert_equal(true,  zu_kalt?(15))
    assert_equal(false, zu_kalt?(16))

    assert_raise(RT)  {zu_kalt?('string')}
  end

  def test_zu_warm?
    assert_equal(true,  zu_warm?(23))
    assert_equal(false, zu_warm?(22))

    assert_raise(RT)  {zu_warm?('string')}
  end

  def test_angenehm?
    assert_equal(true,   angenehm?(19))
    assert_equal(false,  angenehm?(30))

    assert_raise(RT)     {angenehm?('string')}
  end
  def test_unangenehm?
    assert_equal(true,    unangenehm?(30))
    assert_equal(false,   unangenehm?(19))

    assert_raise(RT)      {unangenehm?('string')}
  end
end
