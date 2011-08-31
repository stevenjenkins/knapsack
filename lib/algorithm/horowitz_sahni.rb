require 'lib/knapsack'
require 'lib/algorithm'

# One of the interesting challenges is to encode an algorithm
# as a class, not a method.  Or do I want an algorithm to be a method?
# Hmm.
#
# A consideration here is if breaking apart the 5 major blocks of the HS
# algorithm into separate methods would be useful.  That will let us
# maintain global state as instance variables.
class Algorithm
  class Horowitz_Sahni
    def initialize
    end
    def run
    end

    # The 5 major steps:
    def step_1
      @z = 0
      @z_hat = 0
      @c_hat = 0
      @p[@n+1] = 0
      @w[@n+1] = Algorithm::INF
      @j = 1
    end

    # Computer upper bound U_1
    def step_2
    end

    def step_3
    end

    def step_4
    end

    def step_5
    end

  end
end
