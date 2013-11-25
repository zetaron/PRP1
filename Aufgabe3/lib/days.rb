$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
require 'ext_pr1_v4'

require 'daysym'
require 'daynum'

EU_DAY_SYM_SEQ = DAY_SYM_SEQ.map { |day_sym| DaySym[day_sym] }
# US_DAY_SYM_SEQ = DAY_SYM_SEQ.map { |day_sym| DaySym[day_sym].shift(-1) }


# day_shift :: Day x Int -> Day
#
# Test (
#   (DaySym[:MO], -2) => DaySym[:SA]
# )
def day_shift(day, shift)
  check_pre((
    (day?(day)) and
    (shift.int?)
  ))

  if shift.int_neg?
    return day_pred(day, shift.abs)
  else
    return day_succ(day, shift.abs)
  end
end


# day_num? :: Any :: (day) ->? Bool
#
# Test (
#   (1) => true,
#   (9) => false,
#   ('str') => false
# )
def day_num_elem?(day)
  if day.int?
    return ((day >= 1) and (day <= DAY_SYM_SEQ.length))
  end

  return false
end

# day_sym_elem? :: Any :: (day) ->? Bool
#
# Test (
#   (:MO) => true,
#   (:LA) => false,
#   ('str') => false
# )
def day_sym_elem?(day)
  return DAY_SYM_SEQ.include?(day)
end

# day? :: Any :: (day) ->? Bool
#
# Test (
#   (:MO) => true,
#   (:LA) => false,
#   (1) => true,
#   (9) => false,
#   ('str') => false
# )
def day?(day)
  return (day_num_elem?(day) or day_sym_elem?(day) or day.day_sym? or day.day_num?)
end

# day_num_to_day_sym :: Num :: (day_num) ->? Sym
#
# Test (
#   (1) => :MO,
#   (7) => :SO,
#   (:MI) => Err,
#   ('str') => Err
# )
def day_num_to_day_sym(day_num)
  check_pre((
    (day_num_elem?(day_num)) or
    (day_num.day_num?)
  ))

  if day_num_elem?(day_num)
    DayNum.new(day_num).to_sym
  elsif day_num.day_num?
    day_num.to_sym
  end
end

# day_sym_to_day_num :: Sym :: (day_sym) ->? Num
#
# Test (
#   (:MO) => 1,
#   (:SO) => 7,
#   (3) => Err,
#   ('str') => Err
# )
def day_sym_to_day_num(day_sym)
  check_pre((
    (day_sym_elem?(day_sym))
  ))

  return index_to_day_num(DAY_SYM_SEQ.find_index(day_sym))
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

  if day_sym_elem?(day)
    return day
  elsif day.day_sym?
    return day.to_sym
  elsif day_num_elem?(day)
    return day_num_to_day_sym(day)
  elsif day.day_num?
    return day.to_sym
  end

  raise("Can't convert day of type '" + day.type.to_str + "' to day symbol")
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

  if day.day_num?
    return day.to_num
  elsif day_sym_elem?(day) or day.day_sym?
    return day_sym_to_day_num(day)
  end

  return day

  raise("Can't convert day of type '" + day.type.to_str + "' to day number")
end

# day_num_succ :: Nat x Nat -> Nat :: (day_num, times)
#
# Test (
#   (1) => 2,
#   (7) => 1,
#   ('str') => Err,
#
#   (1, 6) => 7,
#   (1, 'str') => Err
# )
def day_num_succ(day_num, times = 1)
  check_pre((
    (
      (day_num_elem?(day_num)) or
      (day_num.day_num?)
    ) and
    (times.nat?)
  ))

  if day_num_elem?(day_num)
    day = DayNum.new(day_num)
  end

  day = day.shift(times)

  if day_num_elem?(day_num)
    day = day.to_num
  end

  return day
end

# day_num_pred :: Nat x Nat -> Nat :: (day_num, times)
#
# Test (
#   (1) => 7,
#   (7) => 6,
#   ('str') => Err,
#
#   (1, 6) => 2,
#   (1, 'str') => Err
# )
def day_num_pred(day_num, times = 1)
  check_pre((
    (
      (day_num_elem?(day_num)) or
      (day_num.day_num?)
    ) and
    (times.nat?)
  ))

  if day_num_elem?(day_num)
    day = DayNum.new(day_num)
  end

  day = day.shift(-times.abs)

  if day_num_elem?(day_num)
    day = day.to_num
  end

  return day
end

# day_sym_succ :: Sym x Any -> Sym :: (day_sym, times)
#
# Test (
#   (:MO) => :DI,
#   (:SO) => :MO,
#   ('str') => Err,
#
#   (:MO, 6) => :SO
# )
def day_sym_succ(day_sym, times = 1)
  check_pre((
    (
      (day_sym_elem?(day_sym)) or
      (day_sym.day_sym?)
    ) and
    (times.nat?)
  ))

  if day_sym_elem?(day_sym)
    day = DaySym.new(day_sym)
  end

  day = day.shift(times)

  if day_sym_elem?(day_sym)
    day = day.to_sym
  end

  return day
end

# day_sym_pred :: Sym x Any -> Sym :: (day_sym, times)
#
# Test (
#   (:MO) => :SO,
#   (:SO) => :SA,
#   ('str') => Err,
#
#   (:MO, 6) => :DI
# )
def day_sym_pred(day_sym, times = 1)
  check_pre((
    (
      (day_sym_elem?(day_sym)) or
      (day_sym.day_sym?)
    ) and
    (times.nat?)
  ))

  if day_sym_elem?(day_sym)
    day = DaySym.new(day_sym)
  end

  day = day.shift(-times.abs)

  if day_sym_elem?(day_sym)
    day = day.to_sym
  end

  return day
end

# day_succ :: Any x Any -> Any :: (day, times)
#
# times wird in den entsprechenden functionen im detail getestet
#
# Test (
#   (1) => 2,
#   (:MO) => :DI,
#   ('str') => Err,
#
#   (:MO, 6) => :SO,
#   (1, 6) => 7
# )
def day_succ(day, times = 1)
  check_pre((
    (day?(day))
  ))

  if (day_num_elem?(day) or day.day_num?)
    return day_num_succ(day, times)
  elsif (day_sym_elem?(day) or day.day_sym?)
    return day_sym_succ(day, times)
  end
end

# day_succ :: Any x Any :: (day, times) ->? Any
#
# times wird in den entsprechenden functionen im detail getestet
#
# Test (
#   (1) => 7,
#   (:MO) => :SO,
#   ('str') => Err,
#
#   (:MO, 6) => :DI,
#   (1, 6) => 2
# )
def day_pred(day, times = 1)
  check_pre((
    (day?(day))
  ))

  if (day_num_elem?(day) or day.day_num?)
    return day_num_pred(day, times)
  elsif (day_sym_elem?(day) or day.day_sym?)
    return day_sym_pred(day, times)
  end
end





# helper methods for readability

# index_to_day :: Int :: (index) ->? Int
def index_to_day_num(index)
  check_pre((
    (index.int?)
  ))

  return index + 1
end

# day_to_index :: Int :: (day_num) ->? Int
def day_num_to_index(day_num)
  check_pre((
    (day_num.int?)
  ))

  return day_num - 1
end