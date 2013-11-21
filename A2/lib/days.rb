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

 # index_to_day :: Int :: (index) ->? Int
def index_to_day(index)
  check_pre((
    (index.int?)
  ))

  return index + 1
end

# day_to_index :: Int :: (day_num) ->? Int
def day_to_index(day_num)
  check_pre((
    (day_num.int?)
  ))

  return day_num - 1
end


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

# day_num_to_day_sym :: Num :: (day_num) ->? Sym
#
# Test (
#   (1) => :MO,
#   (7) => :SO,
#   (:MI) => ERR,
#   ('stuff') => ERR
# )
def day_num_to_day_sym(day_num)
  check_pre((
    (day_num?(day_num))
  ))

  return DAY_SYM_ARR.at(day_to_index(day_num))
end

# day_sym_to_day_num :: Sym :: (day_sym) ->? Num
#
# Test (
#   (:MO) => 1,
#   (:SO) => 7,
#   (3) => ERR,
#   ('stuff') => ERR
# )
def day_sym_to_day_num(day_sym)
  check_pre((
    (day_sym?(day_sym))
  ))

  return index_to_day(DAY_SYM_ARR.find_index(day_sym))
end

# to_day_sym :: Any :: (day) ->? Sym
#
# Test (
#   (4) => :DO,
#   (:FR) => :FR,
#   ('SO') => Err (my raise)
# )

def to_day_sym(day)
  check_pre((
    (day?(day))
  ))

  if day_sym?(day)
    return day
  elsif day_num?(day)
    return day_num_to_day_sym(day)
  end
end

# to_day_num :: Any :: (day) ->? Num
#
# Test (
#   (4) => 4,
#   (:FR) => 5,
#   ('SO') => Err (my raise)
# )
def to_day_num(day)
  check_pre((
    (day?(day))
  ))

  if day_num?(day)
    return day
  elsif day_sym?(day)
    return day_sym_to_day_num(day)
  end
end

# day_num_succ :: Num :: (day_num) ->? Num
#
# Test (
#   (1) => 2,
#   (7) => 1,
#   ('stuff') => ERR
# )
def day_num_succ(day_num)
  check_pre((
    (day_num?(day_num))
  ))

  day_num_succ = day_num.succ

  return (day_num?(day_num_succ) ? day_num_succ : 1)
end

# day_num_pred :: Num :: (day_num) ->? Num
#
# Test (
#   (1) => 7,
#   (7) => 6,
#   ('stuff') => ERR
# )
def day_num_pred(day_num)
  check_pre((
    (day_num?(day_num))
  ))

  day_num_pred = day_num.pred

  return (day_num?(day_num_pred) ? day_num_pred : DAY_SYM_ARR.length)
end

# day_sym_succ :: Sym :: (day_sym) ->? sym
#
# Test (
#   (:MO) => :DI,
#   (:SO) => :MO,
#   ('stuff') => ERR
# )
def day_sym_succ(day_sym)
  check_pre((
    (day_sym?(day_sym))
  ))

  index = day_to_index(day_num_succ(index_to_day(DAY_SYM_ARR.find_index(day_sym))))
  return DAY_SYM_ARR.at(index)
end

# day_sym_pred :: Sym :: (day_sym) ->? sym
#
# Test (
#   (:MO) => :SO,
#   (:SO) => :SA,
#   ('stuff') => ERR
# )
def day_sym_pred(day_sym)
  check_pre((
    (day_sym?(day_sym))
  ))

  index = day_to_index(day_num_pred(index_to_day(DAY_SYM_ARR.find_index(day_sym))))
  return DAY_SYM_ARR.at(index)
end

# day_succ :: Any :: (day) ->? Any
#
# Test (
#   (1) => 2,
#   (:MO) => :DI,
#   ('stuff') => ERR
# )
def day_succ(day)
  check_pre((
    (day?(day))
  ))

  if day_num?(day)
    return day_num_succ(day)
  elsif day_sym?(day)
    return day_sym_succ(day)
  end
end

# day_pred :: Any :: (day) ->? Any
#
# Test (
#   (1) => 7,
#   (:MO) => :SO,
#   ('stuff') => ERR
# )
def day_pred(day)
  check_pre((
    (day?(day))
  ))

  if day_num?(day)
    return day_num_pred(day)
  elsif day_sym?(day)
    return day_sym_pred(day)
  end
end