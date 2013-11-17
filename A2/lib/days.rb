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

# day_num? :: Any :: (day) ->? Bool
#
# Test (
#   1 => true,
#   2 => true,
#   8 => false,
#   'stuff' => false
# )
def day_num?(day)
  if day.int?
    return ((day >= 1) and (day <= DAY_SYM_ARR.length))
  end

  return false
end

# day_sym? :: Any :: (day) ->? Bool
#
# Test (
#   (:MO) => true,
#   (:Di) => true,
#   (:TO) => false,
#   ('stuff') => false
# )
def day_sym?(day)
  return DAY_SYM_ARR.include?(day)
end

# day? :: Any :: (day) ->? Bool
#
# Test (
#   (:MO) => true,
#   (:DI) => true,
#   (:TO) => false,
#   (1) => true,
#   (8) => false,
#   ('stuff') => false
# )
def day?(day)
  return (day_num?(day) or day_sym?(day))
end