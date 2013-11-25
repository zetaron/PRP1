$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
require 'ext_pr1_v4'

require 'day'

class Day
  def to_day_sym
    DaySym.from_index(to_index)
  end
end

class DaySym < Day

  def invariant?
    value.is_a? Symbol and value.in? DAY_SYM_SEQ
  end

  def day_sym?
    true
  end

  def to_index
    DAY_SYM_SEQ.find_index value
  end

  def self.from_index(index)
    check_pre((
      (index.int?)
    ))

    DaySym.new(DAY_SYM_SEQ.at(index))
  end

end
Object.def_false(:day_sym?)
