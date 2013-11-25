$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
require 'ext_pr1_v4'

require 'day'

class Day
  def to_day_num
    DayNum.from_index(to_index)
  end
end

class DayNum < Day

  def invariant?
    (value >= 1) and (value <= DAY_SYM_SEQ.length)
  end

  def day_num?
    true
  end

  def to_index
    value - 1
  end

  def self.from_index(index)
    check_pre((
      (index.int?)
    ))

    DayNum.new(index + 1)
  end

end
Object.def_false(:day_num?)
