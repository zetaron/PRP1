
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'hollow_cube_volume'

class HollowCubeVolumeTest < Test::Unit::TestCase

  RT = RuntimeError

  def test_hollow_cube_volume
    #successfull tests
    assert_equal(19,  hollow_cube_volume(3,2))
    assert_equal(0,   hollow_cube_volume(2,2))
    assert_equal(0,   hollow_cube_volume(0,0))

    
    #failing tests
    assert_raise(RT)  {hollow_cube_volume('some',5)}
    assert_raise(RT)  {hollow_cube_volume(5,'string')}
    assert_raise(RT)  {hollow_cube_volume(-1,5)}
    assert_raise(RT)  {hollow_cube_volume(3,-5)}
    assert_raise(RT)  {hollow_cube_volume(2,3)}
  end

  # Test (
  #   (2,2,4)=>0,
  #   (3,2,5)=> 211,
  #   (1,2,'3')=>Err,
  #   (3,5,-8)=>Err,
  #   (3,5,0)=>Err,
  # )
  def test_hollow_cube_volume_n
    assert_equal(0,  hollow_cube_volume(2,2,4))
    assert_equal(211, hollow_cube_volume(3,2,5))

    assert_raise(RT)  {hollow_cube_volume(1,2,'3')}
    assert_raise(RT)  {hollow_cube_volume(3,5,-8)}
    assert_raise(RT)  {hollow_cube_volume(3,5,0)}
  end
end
