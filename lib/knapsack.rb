# Since the profits and weights are both indexed, as well
# as connected (ie, p[i] and w[i] refer to the same item),
# we'll put them into a single array.
class Knapsack
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
    partitions = @items.partition do |item|
      s_accumulator = s_accumulator + item.w
      s_accumulator <= @c
    end
    # We use this next value in several places, but Martello and
    # Toth don't give it a name.  Thus I'll call it 'fitting weights'
    # because they are the weights that fit into the knapsack.
    @fitting_weights = partitions[0]
    # The complement of @fitting_weights is @remaining_weights
    @remaining_weights = partitions[1]
    # Martello and Toth do name @s, but we add 1 as they use 1-based indexing
    @s = @fitting_weights.length + 1
    self
  end

  def p(j)
    item[p][j]
  end

  def sum_profits
    @items.map {|i| i.p}.reduce(:+)
  end

  def sum_weights
    @items.map {|i| i.w}.reduce(:+)
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
