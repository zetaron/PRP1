$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
require 'ext_pr1_v4'

require 'config'

class Day

  def day?
    true
  end

  # initialize :: (value) :: Any ->? Day
  #   throws ArgumentError
  def initialize(value)
    @value = value

    raise ArgumentError unless invariant?
  end

  # self.[] :: (value) :: Any ->? Day
  def self.[](value)
    self.new(value)
  end

  # value -> Any
  def value
    @value
  end

  # shift :: (shift) :: Int ->? Day
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

  # normalize_index :: (index) :: Int -> +Int
  def normalize_index(index)
    check_pre((
      (index.int?)
    ))

    index % DAY_SYM_SEQ.length
  end
  
  # succ ->? Day
  def succ
    from_index(normalize_index(to_index.succ))
  end

  # pred ->? Day
  def pred
    from_index(normalize_index(to_index.pred))
  end

  # from_index :: (index) :: Int ->? Day
  def from_index(index)
    self.class.from_index(index)
  end

  # + :: (obj) :: Day ->? Day
  def +(value)
    check_pre((
      (value.int?)
    ))

    from_index(normalize_index(to_index + value))
  end

  # - :: (obj) :: Day ->? Day
  def -(value)
    check_pre((
      (value.int?)
    ))

    from_index(normalize_index(to_index - value))
  end

  # == :: (obj) :: Any -> Bool
  def ==(obj)
    return false unless obj.kind_of? self.class

    value == obj.value
  end


  # === Abstract methods =======================================================

  # invariant? -> Bool
  def invariant?
    raise NotImplementedError, "invariant? is not yet implemented"
  end

  # to_index -> +Int
  def to_index
    raise NotImplementedError, "to_index is not yes implemented"
  end

  # self.from_index :: (index) :: +Int ->? Day
  def self.from_index(index)
    raise NotImplementedError, "self.from_index is not yes implemented"
  end

end
Object.def_false(:day?)
