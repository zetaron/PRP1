$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
require 'ext_pr1_v4'

require 'config'
require 'daynum'

def_class(:DaySym, [:sym]) {

  def invariant?
    to_sym.in?(DAY_SYM_SEQ)
  end

  # to_daysym -> Sym
  def to_sym
    self.sym
  end

  def to_daysym
    self
  end

  # from_sym :: Sym -> DaySym
  def from_sym(sym)
    #check_pre((
    #  (DaySym[sym].invariant?)
    #))

    #DaySym[sym]
    DaySym.new(sym)
  end

  def to_index
    DAY_SYM_SEQ.find_index(to_sym)
  end

  def from_index(index)
    from_sym(DAY_SYM_SEQ.at(index))
  end

  def to_daynum
    DayNum[1].from_index(to_index)
  end

  def to_num
    to_daynum.to_num
  end

  # shift :: Int -> DaySym
  #
  # Test (
  #   DaySym[:MO].shift(-2) => DaySym[:SA]
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
  #   DayNum[:MO].succ => DayNum[:DI]
  # )
  def succ
    from_index(to_index.succ % DAY_SYM_SEQ.length)
  end

  # pred -> DayNum
  #
  # Test (
  #   DaySym[:MO].pred => DayNum[:SO]
  # )
  def pred
    from_index(to_index.pred % DAY_SYM_SEQ.length)
  end
}