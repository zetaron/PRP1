 $LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
 require 'ext_pr1_v4'


 # volume of a hollow cube ::= (length_outer,length_inner) ::
 # Nat x Nat ->? Nat ::::
 # (length_outer >= length_inner) ::


 def hollow_cube_volume(length_inner,length_outer)

  volume_cube(lentgh_outer)-volume_cube(length_outer)
  
 end

 def volume_cube(length)
   (length**3)
 end