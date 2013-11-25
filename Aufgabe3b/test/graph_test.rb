# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'graph'

class GraphTest < Test::Unit::TestCase

  RT = RuntimeError

  def setup
    @shape_range1d = Range1d[5,9]
    @shape_union1d = Union1d[@shape_range1d, Range1d[1,4]]
    @shape_range2d = Range2d[@shape_range1d, Range1d[2,4]]
    @shape_union2d = Union2d[@shape_range2d, Range2d[Range1d[20,23], Range1d[23,45]]]

    # translated by 1
    @translate_shape_range1d = Range1d[6,10]
    @translate_shape_union1d = Union1d[@translate_shape_range1d, Range1d[2,5]]
    @translate_shape_range2d = Range2d[@translate_shape_range1d, Range1d[3,5]]
    @translate_shape_union2d = Union2d[@translate_shape_range2d, Range2d[Range1d[21,24], Range1d[24, 46]]]
  end

  def test_shape_include_range1d
    assert_equal(true, shape_include?(@shape_range1d, 6))
    assert_equal(false, shape_include?(@shape_range1d, 4))
  end

  def test_shape_include_union1d
    assert_equal(true, shape_include?(@shape_union1d, 6))
    assert_equal(false, shape_include?(@shape_union1d, 0))
    assert_equal(false, shape_include?(@shape_union1d, 10))
    assert_equal(true, shape_include?(@shape_union1d, 3))
  end

  def test_shape_include_range2d
    assert_equal(true, shape_include?(@shape_range2d, 6))
    assert_equal(false, shape_include?(@shape_range2d, 10))
  end

  def test_shape_include_union2d
    assert_equal(true, shape_include?(@shape_union2d, 6))
    assert_equal(true, shape_include?(@shape_union2d, 3))
    assert_equal(true, shape_include?(@shape_union2d, 21))
    assert_equal(true, shape_include?(@shape_union2d, 30))
    assert_equal(false, shape_include?(@shape_union2d, 50))
    assert_equal(false, shape_include?(@shape_union2d, 0))
  end

  def test_shape_translate_range1d
    assert_equal(@translate_shape_range1d, shape_translate(@shape_range1d, 1))
    assert_equal(@translate_shape_union1d, shape_translate(@shape_union1d, 1))
    assert_equal(@translate_shape_range2d, shape_translate(@shape_range2d, 1))
    assert_equal(@translate_shape_union2d, shape_translate(@shape_union2d, 1))

    assert_raise(RT) { shape_translate(@shape_range1d, "2") }
  end

  def test_bounding_range
    assert_equal(Range1d[1,7], bounding_range(Range1d[1,5], Range1d[4,7]))
    
    assert_equal(
      Range2d[Range1d[1,7], Range1d[10,30]],
      bounding_range(
        Range2d[Range1d[1,6], Range1d[10,15]],
        Range2d[Range1d[5,7], Range1d[20,30]]
      )
    )
  end

  def test_bounds
    assert_equal(Range1d[1,5], bounds(Union1d[Range1d[3,5], Range1d[1,2]]))

    assert_equal(
      Range2d[Range1d[3,6], Range1d[1,8]],
      bounds(
        Union2d[
          Range2d[Range1d[3,5], Range1d[1,4]],
          Range2d[Range1d[4,6], Range1d[7,8]]
        ]
      )
    )
  end

  def test_equal_by_dim?
    assert_equal(true, equal_by_dim?(Range1d[1,2], Range1d[45,81]))
    assert_equal(false, equal_by_dim?(Range1d[1,2], Range2d[Range1d[1,2], Range1d[3,4]]))

    assert_equal(true, equal_by_dim?(Range1d[1,2], Union1d[Range1d[3,5], Range1d[6,9]]))
  end

  def test_equal_by_tree?
    assert_equal(true, equal_by_tree?(@shape_union2d, @shape_union2d))
    assert_equal(false, equal_by_tree?(@shape_union2d, @shape_union1d))
  end

  def test_shape_left_point
    assert_equal(5, shape_lowest_left_point(@shape_union2d))
    assert_equal(5, shape_lowest_left_point(@shape_union1d))
  end

  def test_equal_by_trans?
    assert_equal(true, equal_by_trans?(@shape_union2d, @shape_union2d))

    assert_equal(false, equal_by_trans?(@shape_range2d, @shape_union2d))
    assert_equal(false, equal_by_trans?(@shape_range1d, @shape_union2d))
  end
end
