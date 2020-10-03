# frozen_string_literal: true

class GenericDiscount
  def initialize(discount_amount:, discount_at:)
    @discount_amount = discount_amount
    @discount_at = discount_at
  end

  def discount(sumtotal:)
    if sumtotal >= discount_at
      sumtotal - (sumtotal * (discount_amount / 100))
    else
      sumtotal
    end
  end

  private

  attr_reader :discount_amount, :discount_at
end
