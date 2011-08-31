require 'test_helper'

class KnapsackTest < Test::Unit::TestCase
  def test_knapsack_creation
    n = 7
    p = [70, 20, 39]
    w = [31, 10, 20]
    c = 50
    kp = Knapsack.new(n, p, w, c)
    assert_equal(kp.class, Knapsack)
    assert_equal(kp.n, n)
    assert_equal(kp.c, c)
    assert_equal(kp.items.length, p.length)
    # Verify that we kept the mapping between p_i and w_i
    kp.items.each_with_index do |item, index|
      assert_equal(item.p, p[index])
      assert_equal(item.w, w[index])
    end
    # Ensure we didn't drop any profits or weights
    assert_equal(kp.sum_profits, p.reduce(0){|sum,item| sum + item })
    assert_equal(kp.sum_weights, w.reduce(0){|sum,item| sum + item })
    # Since c is 50, the first item that doesn't fit is 20, which has index 3
    # Keep in mind that Martello and Toth use 1-based indexing, not 0-based.
    assert_equal(kp.s, 3)

    # c_bar = c - sum of weights that fit, i.e., 50 - (31 + 10) = 9
    assert_equal(kp.c_bar, 9)

    # U_1 = 70 + 20 + floor(9 * 39 / 20) = 90 + 17 = 107
    # Don't forget that U_1 is about summing the profits, not the weights.
    assert_equal(kp.U_1, 107)
  end
end

class ItemTest < Test::Unit::TestCase
  def test_valid_item_creation
    p = 3
    w = 4
    i = Item.new(p,w)
    assert_equal(i.class, Item)
    assert_equal(i.p, p)
    assert_equal(i.w, w)
  end

  def test_invalid_profit_item_creation
    p = -3
    w = 4
    assert_raise ArgumentError do
      Item.new(p,w)
    end
    p = 3.5
    assert_raise ArgumentError do
      Item.new(p,w)
    end
  end

  def test_invalid_weight_item_creation
    p = 3
    w = -4
    assert_raise ArgumentError do
      Item.new(p,w)
    end
    w = 4.5
    assert_raise ArgumentError do
      Item.new(p,w)
    end
  end
end
