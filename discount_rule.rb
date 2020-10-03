class DiscountRule
  def initialize(discount_price:, minimum_amount:, sku:)
    @discount_price = discount_price
    @minimum_amount = minimum_amount
    @sku = sku
  end

  def handles?(product_id:)
    sku == product_id
  end

  def price_for(product:, quantity:)
    if quantity >= minimum_amount
      discount_price * quantity
    else
      product.price * quantity
    end
  end

  private

  attr_reader :discount_price, :minimum_amount, :sku
end
