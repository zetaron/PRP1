# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'pentagondodekaeders_surface'

class PentagondodekaedersSufaceTest < Test::Unit::TestCase

  RT = RuntimeError

  # Test (
  #   (2) => 82.5829152283,
  #   (0) => 0,
  #   (-2) => Err,
  #   ('2') => Err
  # )
  def test_pentagondodekaeders_suface
    assert_in_delta(82.5829152283, pentagondodekaeders_surface(2), 0.0000000001)

    assert_equal(0, pentagondodekaeders_surface(0))

    assert_raise(RT) { pentagondodekaeders_surface(-2) }
    assert_raise(RT) { pentagondodekaeders_surface('2') }
  end
end
