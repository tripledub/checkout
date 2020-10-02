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

  describe ':handles?' do
    subject { rule.handles?(product_id: product_id) }

    context 'when sku of rule matches product_id' do
      let(:product_id) { '001' }

      it { is_expected.to eq(true) }
    end

    context 'when sku of rule does not match product_id' do
      let(:product_id) { '002' }

      it { is_expected.to eq(false) }
    end
  end
end
