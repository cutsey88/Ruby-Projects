def stock_picker(array)
  big_money = 0
  buy_at = 0
  sell_at = 0
  array.each_with_index do |buy_price, buy_index|
    array.drop(buy_index + 1).each_with_index do |sell_price, sell_index|
      if buy_price < sell_price && big_money < sell_price - buy_price
        big_money = sell_price - buy_price
        buy_at = buy_index
        sell_at = buy_index + sell_index + 1
      end
    end
  end
  [buy_at, sell_at]
end