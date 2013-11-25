$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
require 'ext_pr1_v4'

def point1d?(value)
  value.int?
end

def shape1d?(value)
  (value.range1d? or value.union1d?)
end

def_class(:Range1d, [:first, :last]) {
  def invariant?
    (point1d?(first) and point1d?(last))
  end

  def include?(value)
    value.in?(first..last)
  end

  def translate(point)
    Range1d.new(first + point, last + point)
  end
}

def_class(:Union1d, [:left, :right]) {
  def invariant?
    (shape1d?(left) and shape1d?(right))
  end

  def include?(value)
    (
      left.include?(value) or
      right.include?(value)
    )
  end

  def translate(point)
    Union1d.new(left.translate(point), right.translate(point))
  end
}


def shape2d?(value)
  (value.range2d? or value.union2d?)
end

def_class(:Point2d, [:x, :y]) {
  def invariant?
    (point1d?(x) and point1d?(y))
  end
}

def_class(:Range2d, [:x_range, :y_range]) {
  def invariant?
    ((x_range.range1d?) and (y_range.range1d?))
  end

  def include?(value)
    (
      x_range.include?(value) or
      y_range.include?(value)
    )
  end

  def translate(point)
    Range2d.new(x_range.translate(point), y_range.translate(point))
  end
}

def_class(:Union2d, [:left, :right]) {
  def invariant?
    (shape2d?(left) and shape2d?(right))
  end

  def include?(value)
    (
      left.include?(value) or
      right.include?(value)
    )
  end

  def translate(point)
    Union2d.new(left.translate(point), right.translate(point))
  end
}


def point?(value)
  (point1d?(value) or value.point2d?)
end

def prim_shape?(value)
  (value.range1d? or value.range2d?)
end

def union_shape?(value)
  (value.union1d? or value.union2d?)
end

def comp_shape?(value)
  union_shape?(value)
end

def shape?(value)
  (prim_shape?(value) or comp_shape?(value))
end

def graph_obj?(value)
  (point?(value) or shape?(value))
end


# shape_include? ::= (shape, point) :: Shape x Point -> Bool
def shape_include?(shape, point)
  check_pre((
    (shape?(shape)) and
    (point?(point))
  ))

  shape.include?(point)
end


# translate :: (shape, point) :: Shape x Point -> Shape
def shape_translate(shape, point)
  check_pre((
    (shape?(shape)) and
    (point?(point))
  ))

  shape.translate(point)
end


# bounding_range ::= (r1, r2) :: (Range1d x Range1d) -> Range1d |
#                                (Range2d x Range2d) -> Range2d
def bounding_range(r1, r2)
  check_pre((
    (prim_shape?(r1)) and
    (prim_shape?(r2))
  ))

  if r1.range1d? and r2.range1d?
    lower = (r1.first < r2.first) ? r1.first : r2.first
    upper = (r1.last < r2.last) ? r2.last : r1.last

    Range1d.new(lower, upper)
  elsif r1.range2d? and r2.range2d?
    x_range = bounding_range(r1.x_range, r2.x_range)
    y_range = bounding_range(r1.y_range, r2.y_range)

    Range2d.new(x_range, y_range)
  else
    check_pre(false)
  end
end

# bounds ::= (shape) :: Shape -> (Range1d | Range2d)
def bounds(shape)
  check_pre((
    (shape?(shape))
  ))

  if comp_shape?(shape)
    b1 = bounds(shape.left)
    b2 = bounds(shape.right)

    return bounding_range(b1, b2)
  elsif prim_shape?(shape)
    return shape
  else
    check_pre(false)
  end
end

# equal_by_dim? ::= GraphObj x GraphObj -> Bool
def equal_by_dim?(g1, g2)
  check_pre((
    (graph_obj?(g1)) and
    (graph_obj?(g2))
  ))

  return (
    (shape1d?(g1) and shape1d?(g2)) or
    (shape2d?(g1) and shape2d?(g2))
  )
end

# equal_by_tree? ::= GraphObj x GraphObj -> Bool
def equal_by_tree?(g1, g2)
  check_pre((
    (graph_obj?(g1)) and
    (graph_obj?(g2))
  ))

  if not equal_by_dim?(g1, g2)
    return false
  end

  if comp_shape?(g1) and comp_shape?(g2)
    return (equal_by_tree?(g1.left, g2.left) and equal_by_tree?(g1.right, g2.right))
  elsif g1.range2d? and g2.range2d?
    return (equal_by_tree?(g1.x_range, g2.x_range) and equal_by_tree?(g1.y_range, g2.y_range))
  elsif g1.range1d? and g2.range1d?
    return (
      (g1.first == g2.first) and
      (g1.last == g2.last)
    )
  else
    return false
  end
end

# equal_by_trans? ::= GraphObj x GraphObj -> Bool
def equal_by_trans?(g1, g2)
  check_pre((
    (graph_obj?(g1)) and
    (graph_obj?(g2))
  ))

  # pick two points
  # sub p1 from p2
  # translate p2 by diff
  # check equal_by_tree

  if not equal_by_dim?(g1, g2)
    return false
  end

  p1 = shape_lowest_left_point(g1)
  p2 = shape_lowest_left_point(g2)

  tp1 = p1 - p2
  tg1 = g2.translate(tp1)

  return equal_by_tree?(g1, tg1)
end

# shape_lowest_left_point ::= Shape :: ->? Point1d
def shape_lowest_left_point(shape)
  check_pre((
    shape?(shape)
  ))

  if shape.range1d?
    return shape.first
  elsif shape.range2d?
    return shape_lowest_left_point(shape.x_range)
  elsif shape.union1d? or shape.union2d?
    return shape_lowest_left_point(shape.left)
  else
    check_pre(false)
  end
end