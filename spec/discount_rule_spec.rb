require_relative '../discount_rule'

RSpec.describe DiscountRule do
  let(:rule) do
    described_class.new(discount_price: 12, minimum_amount: 4, sku: '001')
  end

  describe ':price_for' do
    let(:quantity) { 5 }
    let(:original_price) { 15 }

    context 'when minimum amount met' do
      it 'applies discount' do
        expect(
          rule.price_for(quantity: quantity, original_price: original_price)
        ).to eq(60)
      end
    end

    context 'when minimum amount not met' do
      let(:quantity) { 1 }
      let(:original_price) { 15 }

      it 'applies no discount' do
        expect(
          rule.price_for(quantity: quantity, original_price: original_price)
        ).to eq(15)
      end
    end
  end
end
