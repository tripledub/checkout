Product = Struct.new(:sku, :price, :title)

PRODUCTS = [
  Product.new('001', 9.25, 'Lavender heart'),
  Product.new('002', 45, 'Personalised cufflinks'),
  Product.new('003', 19.95, 'Kids T-shirt')
].freeze

class Checkout
  DISCOUNT_AT = 60
  DISCOUNT_AMOUNT = 10

  def scan(sku:)
    items[sku] ||= 0
    items[sku] += 1
  end

  def total
    sumtotal = items.inject(0) do |subtotal, (sku, qty)|
      subtotal + price_for(sku: sku, quantity: qty)
    end

    sumtotal >= DISCOUNT_AT ? discounted_total(sumtotal: sumtotal) : sumtotal
  end

  private

  def discounted_total(sumtotal:)
    sumtotal - (sumtotal * 0.1)
  end

  def items
    @items ||= {}
  end

  def price_for(sku:, quantity:)
    line_item = product_for(sku: sku)
    line_item.price * quantity
  end

  def product_for(sku:)
    PRODUCTS.find { |product| product.sku == sku }
  end
end
