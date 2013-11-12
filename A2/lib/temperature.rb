$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
 require 'ext_pr1_v4'

 # zu_kalt?     ::= int -> bool
 # zu_warm?     ::= int -> bool
 # angenehm?    ::= int -> bool
 # unangenehm?  ::= int -> bool
 #
 #  < 16                       -> zu_kalt?
 #  > 22                       -> zu_warm?
 #  ¬ zu_kalt? and ¬ zu_warm?  -> angenehm
 #  ¬ angenehm?                -> unangenehm
 #
 # Test (
 # zu_kalt?
 #      1  -> true
 #      16 -> false
 #
 # zu_warm?
 #      23 -> true
 #      22 -> false
 #
 # angenehm?
 #      16 -> true
 #      22 -> true
 #      15 -> false
 #      23 -> false
 #      
 # unangenehm?
 #      16 -> false
 #      22 -> false
 #      15 -> true
 #      23 -> true
 # )

def temperature?(temp)
    temp.int?
end



def zu_kalt?(temp)
  check_pre((
    temperature?(temp)
  ))
  temp < 16
end

def zu_warm?(temp)
  check_pre((
     temperature?(temp)
  ))
  temp > 22
end

def angenehm?(temp)
 # not zu_kalt?(temp) and not zu_warm?(temp)
 # not (zu_kalt?(temp) or zu_warm?(temp))
 (not zu_kalt?(temp)) ? (not zu_warm?(temp)) : false    #condition ? true:false
end

def unangenehm?(temp)
  not angenehm?(temp)
  #zu_kalt?(temp) or zu_warm?(temp)
end