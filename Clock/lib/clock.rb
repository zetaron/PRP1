$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
require 'ext_pr1_v4'


SECONDS_PER_MINUTE = 60
MINUTES_PER_HOUR = 60
HOURS_PER_DAY = 24
SECONDS_PER_HOUR = SECONDS_PER_MINUTE * MINUTES_PER_HOUR

# add_timearray_to_timearray ::= (current_time, additional_time, as_ampm) ::
#   Array x Array
#   ->? Array[hour, min, sec] or Array[hour, min, sec, ampm]::::
#
#   if as_ampm
#     current_time = [hours, min, sec, 'ampm']
#   else
#     current_time = [hours, min, sec]
#
#   additional_time = [hours, min, sec]
#
# Test (
#   ([1,30,10], [0,30,0]) => [2,0,10]
#   
#   (1, [0,30,0]) => Err
#   ([0,30,0], 1) => Err
#
#   (-1, [0,30,0]) => Err
#   ([0,30,0], -1) => Err
#
#   ('1', [0,30,0]) => Err
#   ([0,30,0], '1') => Err
#
#   ([1,30,10], [0,30,0], true) => [2,0,10,'AM']
#   ([1,30,10], [0,30,0], false) => [2,0,10,'PM']
#   ([1,30,10], [0,30,0], 'false') => Err
# )
def add_timearray_to_timearray(current_time, additional_time, as_ampm = false)
  check_pre((
      (current_time.array?) and
      (additional_time.array?) and
      (as_ampm.bool?)
  ))

  if not (additional_time.length == 3)
    raise(RuntimeError, 'additional_time: Format violation, see specs for details')
  end

  if (as_ampm and (not (current_time.length == 4))) or ((not as_ampm) and (not (current_time.length == 3)))
    raise(RuntimeError, 'current_time: Format violation, see specs for details')
  end


  if as_ampm
    current_time = analogtime_to_time(current_time)
  end

  current_time_sec = time_to_seconds(current_time[0], current_time[1], current_time[2])
  additional_time_sec = time_to_seconds(additional_time[0], additional_time[1], additional_time[2])

  new_time_sec = current_time_sec + additional_time_sec

  timearray = seconds_to_timearray(new_time_sec)

  if as_ampm
    time_to_analogtime(timearray)
  else
    timearray
  end
end

# time_to_seconds ::= (hour, min, sec) :: Nat x Nat x Nat ->? Nat
#   min < MINUTES_PER_HOUR
#   sec < SECONDS_PER_MINUTE
#
# Test (
#   (1,30,10) => 5410,
#   
#   (-1,30,10) => Err,
#   (1,-30,10) => Err,
#   (1,30,-10) => Err,
#
#   ('1',30,10) => Err,
#   (1,'30',10) => Err,
#   (1,30,'10') => Err
# )
def time_to_seconds(hour, min, sec)
  check_pre((
    (
      (hour.nat?) and
      (min.nat?) and
      (sec.nat?)
    ) and
    (
      (min < MINUTES_PER_HOUR) and
      (sec < SECONDS_PER_MINUTE)
    )
  ))

  hour * SECONDS_PER_HOUR + min * SECONDS_PER_MINUTE + sec
end

# seconds_to_time ::= (seconds) :: Nat ->? [hour, min, sec]
#
# Test (
#   (5410) => [1,30,10],
#
#   (-1) => Err,
#   ('1') => Err
# )
def seconds_to_timearray(seconds)
  check_pre((
      (seconds.nat?)
  ))

  hour = seconds / SECONDS_PER_HOUR
  rhour = seconds % SECONDS_PER_HOUR

  min = rhour / SECONDS_PER_MINUTE
  rmin = rhour % SECONDS_PER_MINUTE

  sec = rmin

  [hour, min, sec]
end

# time_to_analogtime :: (time) :: Array[hour, min, sec] ->? [hour, min, sec, ampm]
#
# Test (
#   ([23,30,20]) => [11,30,20,'PM'],
#   ([11,30,20]) => [11,30,20,'AM'],
#   ('string') => Err,
#   (-123) => Err
# )
def time_to_analogtime(time)
  check_pre((
    (time.array?) and
    (time.length == 3)
  ))

  hours = time[0]
  min = time[1]
  sec = time[2]
  ampm = 'AM'

  if hours > (HOURS_PER_DAY / 2)
    ampm = 'PM'
    hours = hours - (HOURS_PER_DAY / 2)
  end

  [hours, min, sec, ampm]
end

# analogtime_to_time :: (analogtime) :: Array[hours, min, sec, ampm]
#   ->? Array[hours, min, sec] ::::
#
# Test (
#   ([11,30,40,'AM']) => [11,30,40],
#   ([11,30,40,'PM']) => [23,30,40],
#   ([11,30,40]) => Err,
#   ('string') => Err,
# )
def analogtime_to_time(analogtime)
  check_pre((
    (analogtime.array?) and
    (analogtime.length == 4)
  ))

  hours = analogtime[0]
  min = analogtime[1]
  sec = analogtime[2]
  ampm = analogtime[3]

  if ampm == 'PM'
    hours = hours + (HOURS_PER_DAY / 2)
  end

  [hours, min, sec]
end