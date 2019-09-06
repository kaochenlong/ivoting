# PORO
class Cart
  def initialize
    @items = []
  end

  def empty?
    @items.empty?
  end

  def add_item(product_id)
    @items << product_id
  end
end
