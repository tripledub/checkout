# frozen_string_literal: true

class Checkout
  class InvalidProductError < StandardError; end

  def initialize(promotional_rules: [])
    @promotional_rules = promotional_rules
  end

  def scan(sku:)
    raise Checkout::InvalidProductError unless product_for(sku: sku)

    items[sku] ||= 0
    items[sku] += 1
  end

  def total
    sumtotal = items.inject(0) do |subtotal, (sku, qty)|
      subtotal + price_for(sku: sku, quantity: qty)
    end

    apply_generic_discount(sumtotal: sumtotal).round(2)
  end

  private

  attr_reader :promotional_rules

  def apply_generic_discount(sumtotal:)
    generic_rule = generic_rule_for_basket

    if generic_rule
      generic_rule.discount(sumtotal: sumtotal)
    else
      sumtotal
    end
  end

  def generic_rule_for_basket
    promotional_rules.find { |rule| rule.is_a?(GenericDiscount) }
  end

  def items
    @items ||= {}
  end

  def price_for(sku:, quantity:)
    rule = rule_for(sku: sku)
    product = product_for(sku: sku)
    if rule
      rule.price_for(product: product, quantity: quantity)
    else
      product.price * quantity
    end
  end

  def product_for(sku:)
    PRODUCTS.find { |product| product.sku == sku }
  end

  def rule_for(sku:)
    promotional_rules.find do |rule|
      rule.is_a?(DiscountRule) && rule.handles?(product_id: sku)
    end
  end
end


Product = Struct.new(:sku, :price, :title)

PRODUCTS = [
  Product.new('001', 9.25, 'Lavender heart'),
  Product.new('002', 45, 'Personalised cufflinks'),
  Product.new('003', 19.95, 'Kids T-shirt')
].freeze
