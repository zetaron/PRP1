 $LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
 require 'ext_pr1_v4'

 DAY_SYM_ARR = [
  :MO,
  :DI,
  :MI,
  :DO,
  :FR,
  :SA,
  :SO
]

  Day_NUM_ARR = [
    1,
    2,
    3,
    4,
    5,
    6,
    7
]

 # Test (
 #   (:MO) => true,
 #   (:Di) => true,
 #   (:TO) => false,
 #   ('stuff') => ERR
 # )
 def_class(:DayNum,[:num]){
   def invariant?
#     num.in? DAY_NUM_ARR
     num.int_pos? and (1..7).include? num
   end
 }

 # Test (
 #   1 => true,
 #   2 => true,
 #   8 => false,
 #   'stuff' => ERR
 # )
 def_class(:DaySym,[:sym]){
   def invariant?
     sym.in? DAY_SYM_ARR
   end
 }

  # Test (
  #   1         => true
  #   (:MO)     => true
  #   8         => false
  #   (:TO)     => false
  #   ('stuff') => ERR 
  # )
 def day?(day)
   day.day_sym? or day.day_num?
 end