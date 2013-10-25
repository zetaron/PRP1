$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
require 'ext_pr1_v4'

# cylinder_volume :: (height, width) :: Nat x Nat ->? Nat ::::
#
# Test (
#   (2, 2) => 12.5663706144 (google: (((2/2)^2)*pi)*2 )
#   (1,2) => Math::PI,
#   (-2, 2) => Err,
#   (2, -2) => Err,
#   ('2', 2) => Err,
#   (2, '2') => Err,
#   (0, 1) => Err,
#   (1, 0) => Err
# )
def cylinder_volume(height, width)
  check_pre((
    (height.nat?) and
    (width.nat?) and
    (height > 0) and
    (width > 0)
  ))

  radius = (width / 2)
  basearea = radius**2 * Math::PI

  height * basearea
end