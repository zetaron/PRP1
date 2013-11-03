$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','extensions/lib')
require 'ext_pr1_v4'

LOWER_ANGENEHM = 16
UPPER_ANGENEHM = 22

# temperature :: Any :: (temp) ->? Bool
def temperature?(temp)
  if not temp.int?
    return false
  end
  
  return true
end

# zu_kalt? :: Int :: (temp) ->? Bool
#
# Test (
#   (40) => false,
#   (14) => true,
#   (true) => Err,
#   ('str') => Err
# )
def zu_kalt?(temp)
  check_pre((
    (temperature?(temp))
  ))

  return (temp < LOWER_ANGENEHM)
end

# zu_warm? :: Int :: (temp) ->? Bool
#
# Test (
#   (40) => true,
#   (14) => false,
#   (true) => Err,
#   ('str') => Err
# )
def zu_warm?(temp)
  check_pre((
    (temperature?(temp))
  ))

  return (temp > UPPER_ANGENEHM)
end

# angenehm? :: Any :: (temp) ->? Bool
#
# Test (
#   (16) => true,
#   (22) => true,
#   (40) => false,
#   (2) => false
# )
def angenehm?(temp)
  isAngenehm = (
    (not zu_kalt?(temp)) and
    (not zu_warm?(temp))
  )

  return isAngenehm
end

=begin
def angenehm?(temp)
  (not zu_kalt?(temp)) ? ((not zu_warm?(temp)) ? true : false) : false
end
=end

# angenehm? ohne AND nur mit OR ist nicht möglich...

# unangenehm? :: Any :: (temp) ->? Bool
#
# Test (
#   (16) => false,
#   (22) => false,
#   (40) => true,
#   (2) => true
# )
def unangenehm?(temp)
  return (not angenehm?(temp))
end