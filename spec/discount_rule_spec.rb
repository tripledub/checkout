require_relative '../discount_rule'

RSpec.describe DiscountRule do
  let(:original_price) { 15 }
  let(:discount_price) { 12 }
  let(:rule) do
    described_class.new(discount_price: discount_price, minimum_amount: 4, sku: '001')
  end

  describe ':price_for' do
    let(:quantity) { 5 }
    let(:original_price) { 15 }

    context 'when minimum amount met' do
      it 'applies discount' do
        expect(
          rule.price_for(quantity: quantity, original_price: original_price)
        ).to eq(discount_price * quantity)
      end
    end

    context 'when minimum amount not met' do
      let(:quantity) { 1 }

      it 'applies no discount' do
        expect(
          rule.price_for(quantity: quantity, original_price: original_price)
        ).to eq(original_price * quantity)
      end
    end
  end
end
