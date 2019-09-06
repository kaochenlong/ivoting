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
end
