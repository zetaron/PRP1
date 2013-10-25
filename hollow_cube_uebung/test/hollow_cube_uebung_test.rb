# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'hollow_cube_uebung'

class Hollow_cube_uebung_test < Test::Unit::TestCase
  def test_hollow_cube
    assert_equal(19, hollow_cube_uebung(3,2))
  end
end
