# PORO
class Cart
  attr_reader :items

  def initialize
    @items = []
  end

  def empty?
    @items.empty?
  end

  def add_item(product_id)
    found_item = @items.find { |i| i.product_id == product_id }

    if found_item
      found_item.increment(1)
    else
      @items << CartItem.new(product_id)
    end
  end

  def total_price
    total = @items.reduce(0) { |sum, item| sum + item.total_price }
    total = total * 0.9 if super_good_day?
    total
  end

  def serialize
    {
      "items" => @items.map do |i|
                   {"product_id" => i.product_id, "quantity" => i.quantity }
                 end
    }
  end

  private
  def xmas?
    #....
    Time.now.day == 25 && Time.now.month == 12
  end

  def super_good_day?
    Time.now.day == 10 && Time.now.month == 2
  end
end
