$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
require 'ext_pr1_v4'

require 'config'
require 'daysym'

def_class(:DayNum, [:num]) {
  def invariant?
    ((to_num >= 1) and (to_num <= DAY_SYM_SEQ.length))
  end

  def to_num
    self.num
  end

  def to_daynum
    self
  end

  def from_num(num)
    check_pre((
      (DayNum[num].invariant?)
    ))

    DayNum.new(num)
  end

  def to_index
    to_num - 1
  end

  def from_index(index)
    from_num(index + 1)
  end

  def to_daysym
    DaySym.new(DAY_SYM_SEQ.at(0)).from_index(to_index)
  end

  def to_sym
    to_daysym.to_sym
  end

  # shift :: Int -> DayNum
  #
  # Test (
  #   DayNum[1].shift(-2) => DayNum[6]
  # )
  def shift(shift)
    check_pre((
      (shift.int?)
    ))

    day = self

    for n in 1 .. shift.abs
      if shift.int_pos?
        day = day.succ
      else
        day = day.pred
      end
    end

    return day
  end

  # succ -> DayNum
  #
  # Test (
  #   DayNum[1].succ => DayNum[2]
  # )
  def succ
    from_index(to_index.succ % DAY_SYM_SEQ.length)
  end

  # pred -> DayNum
  #
  # Test (
  #   DayNum[1].pred => DayNum[7]
  # )
  def pred
    from_index(to_index.pred % DAY_SYM_SEQ.length)
  end
}