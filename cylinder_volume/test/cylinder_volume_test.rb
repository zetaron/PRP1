# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'cylinder_volume'

class CylinderVolumeTest < Test::Unit::TestCase

  RT = RuntimeError

  # Test (
  #   (2, 2) => 12.5663706144 (google: (((2/2)^2)*pi)*2 )
  #   (1,2) => PI,
  #   (-2, 2) => Err,
  #   (2, -2) => Err,
  #   ('2', 2) => Err,
  #   (2, '2') => Err,
  #   (0, 1) => Err,
  #   (1, 0) => Err
  # )
  def test_cylinder_volume
    assert_in_delta(6.28318530718, cylinder_volume(2, 2), 0.0000000001)

    assert_equal(Math::PI, cylinder_volume(1, 2))

    assert_raise(RT) { cylinder_volume(-2, 2) }
    assert_raise(RT) { cylinder_volume(2, -2) }

    assert_raise(RT) { cylinder_volume('2', 2) }
    assert_raise(RT) { cylinder_volume(2, '2') }

    assert_raise(RT) { cylinder_volume(0,1)}
    assert_raise(RT) { cylinder_volume(1,0)}
  end
end
