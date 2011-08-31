# Since the profits and weights are both indexed, as well
# as connected (ie, p[i] and w[i] refer to the same item),
# we'll put them into a single array.
class Knapsack
  # This will fit in a Fixnum on 64-bit systems.
  # If you need a larger  value for max weight or you are on a 32-bit system,
  # then you are going to # need Bignum's, which are significantly
  # slower, so you're better off using a 64-bit system or a C/C++ version
  # that has a Ruby interface instead of a pure Ruby solution.
  #
  # N.B.  On my system in Ruby 1.8.7, 2**62 is a Bignum but 2**61 is a Fixnum.
  INF = 2**61
  attr_accessor :n, :c, :items
  attr_reader :s, :c_bar

  # We don't do error checking on the Knapsack creation
  # because there may be recursion in various algorithms
  # and we don't want to pay the overhead on each iteration.
  # Instead, we will add a pre-check that will do basic
  # checks like ensure profits and weights are of same length,
  # that the items are sorted appropriately, etc.
  # TODO: Add pre-check validation for Knapsacks
  def initialize(n, p, w, c)
    @n = n
    @c = c
    @items = []
    p.each_with_index do |profit, index|
      @items << Item.new(profit, w[index])
    end
    s_accumulator = 0
    @s = @items.take_while do |item|
      s_accumulator = s_accumulator + item.w
      s_accumulator <= @c
    end.length + 1 # add 1 since 1-based indexing for the algorithms
    self
  end

  def p(j)
    item[p][j]
  end

  def sum_profits
    @items.map {|i| i.p}.reduce(0) {|sum,value| sum + value}
  end

  def sum_weights
    @items.map {|i| i.w}.reduce(0) {|sum,value| sum + value}
  end

  # Upper bound on z(KP), from p.17; equation 2.10
  def U_1
  end
end

class Item
  attr_accessor :p, :w
  def initialize(profit,weight)
    validate_profit(profit)
    validate_weight(weight)
    @p = profit
    @w = weight
    self
  end

  private
  def validate_profit(p)
    validate(p)
  end
  def validate_weight(w)
    validate(w)
  end

  # profit and weight have same validation
  def validate(i)
    unless [Fixnum, Bignum].member?(i.class) and i >= 0
      raise ArgumentError, "Must be a positive integer, not " + i.to_s
    end
  end
end
