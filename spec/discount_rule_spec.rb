require_relative '../discount_rule'

RSpec.describe DiscountRule do
  let(:original_price) { 15 }
  let(:discount_price) { 12 }
  let(:minimum_amount) { 4 }

  let(:rule) do
    described_class.new(
      discount_price: discount_price,
      minimum_amount: minimum_amount,
      sku: '001'
    )
  end

  describe ':price_for' do
    context 'when minimum amount met' do
      let(:quantity) { minimum_amount }

      it 'applies discount' do
        expect(
          rule.price_for(quantity: quantity, original_price: original_price)
        ).to eq(discount_price * quantity)
      end
    end

    context 'when minimum amount not met' do
      let(:quantity) { minimum_amount - 1 }

      it 'applies no discount' do
        expect(
          rule.price_for(quantity: quantity, original_price: original_price)
        ).to eq(original_price * quantity)
      end
    end
  end
end
