 $LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
 require 'ext_pr1_v4'

# volume of a hollow cube with n dimensions
# hollow_cube_volume_n ::= Nat x Nat ->? Nat :: (lenght_outer, lenght_inner, dimensions) ::::
# lenght_outer >= lenght_inner ::
# dimensions > 0 ::
# Test (
#   (3,2,3)=>19,
#   (2,2,4)=>0,
#   (2,4,3)=> Err,
#   (3,2,5)=> 211,
#   ('10',5,4)=>Err,
#   (5,'10',5)=>Err,
#   (1,2,'3')=>Err
#   (-1,5,6)=>Err,
#   (3,-5,8)=>Err,
#   (3,5,-8)=>Err
# )
def hollow_cube_volume(length_outer, length_inner, dimensions = 3)
  check_pre((
    (length_outer.nat?) and
    (length_inner.nat?) and
    (dimensions.nat?) and
    (length_outer >= length_inner) and
    (dimensions > 0)
    ))

  cube_volume(length_outer, dimensions) - cube_volume(length_inner, dimensions)
  
end



def cube_volume(length, dimensions = 3)
    length ** dimensions
end

