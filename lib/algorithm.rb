class Algorithm
  # This will fit in a Fixnum on 64-bit systems.
  # If you need a larger value for max weight or you are on a 32-bit system,
  # then you are going to need Bignum's, which are significantly
  # slower, so you're better off using a 64-bit system or a C/C++ version
  # that has a Ruby interface instead of a pure Ruby solution.
  #
  # N.B.  On my system in Ruby 1.8.7, 2**62 is a Bignum but 2**61 is a Fixnum.
  INF = 2**61
end
