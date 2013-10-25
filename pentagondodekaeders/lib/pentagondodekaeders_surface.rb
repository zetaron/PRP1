$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
require 'ext_pr1_v4'

BASE = Math.sqrt(25 + (10 * Math.sqrt(5))) * 3

# pentagondodekaeders_surface :: (a) :: Nat ->? Nat ::::
#
# BASE = sqrt(25 + (10 * sqrt(5))) * 3
# O = (a**2) * BASE
#
# Test (
#   (2) => 82.5829152283,
#   (0) => 0,
#   (-2) => Err,
#   ('2') => Err
# )
def pentagondodekaeders_surface(a)
  check_pre((
    (a.nat?)
  ))

  (a**2) * BASE
end