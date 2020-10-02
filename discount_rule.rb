class DiscountRule
  def initialize(discount_price:, minimum_amount:, sku:)
    @discount_price = discount_price
    @minimum_amount = minimum_amount
    @sku = sku
  end

  def handles?(product_id:)
    sku == product_id
  end

  def price_for(quantity:, original_price:)
    if quantity >= minimum_amount
      discount_price * quantity
    else
      original_price * quantity
    end
  end

  private

  attr_reader :discount_price, :minimum_amount, :sku
end
