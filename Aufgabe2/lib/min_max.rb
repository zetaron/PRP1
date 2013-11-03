$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
require 'ext_pr1_v4'

def min_int(val1, val2)
  check_pre((
      (val1.int?) and
      (val2.int?)
  ))

  val1 < val2 ? val1 :val2
end

def max_int(val1, val2)
  check_pre((
      (val1.int?) and
      (val2.int?)
  ))

  val1 > val2 ? val1 : val2
end

def within?(val, lower, upper)
  check_pre((
      (val.int?) and
      (lower.int?) and
      (upper.int?)
  ))

  ((val >= lower) and (val <= upper))
end