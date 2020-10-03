require_relative '../checkout'
require_relative '../discount_rule'

RSpec.describe Checkout do
  let(:rules) { [] }
  subject { described_class.new(promotional_rules: rules) }

  describe ':scan' do
    let(:sku) { '001' }

    context 'with an existant item' do
      it 'does not raise an error' do
        expect {
          subject.scan(sku: sku)
        }.to_not raise_error
      end
    end

    context 'with a non-existant item' do
      let(:sku) { '007' }

      it 'raises an error' do
        expect {
          subject.scan(sku: sku)
        }.to raise_error(Checkout::InvalidProductError)
      end
    end
  end

  describe ':total' do

    # Product code  | Name                   | Price
    # ----------------------------------------------------------
    # 001           | Lavender heart         | £9.25
    # 002           | Personalised cufflinks | £45.00
    # 003           | Kids T-shirt           | £19.95
    #
    # adding as comments here for now as not using factories
    # for products so tests might not be so clear

    let(:skus) { [] }

    before do
      skus.each do |sku|
        subject.scan(sku: sku)
      end
    end

    context 'when there are zero items in checkout' do
      it 'returns 0' do
        expect(subject.total).to eq(0)
      end
    end

    context 'when there is one of each product' do
      let(:skus) { %w[001 002 003] }

      it 'returns the sum of each product' do
        expect(subject.total).to eq(66.78)
      end
    end

    context 'with rules' do
      let(:rules) { [DiscountRule.new(discount_price: 8.50, minimum_amount: 2, sku: '001')] }

      context 'when there is one of each product and no rules matched' do
        let(:skus) { %w[001 002 003] }

        it 'returns the sum of each product with no item discounts' do
          expect(subject.total).to eq(66.78)
        end
      end

      context 'when quantity for multiple(2) of sku "001" is matched' do
        let(:skus) { %w[001 003 001] }

        it 'returns the correct total' do
          expect(subject.total).to eq(36.95)
        end
      end

      context 'quantity and total price rules matched' do
        let(:skus) { %w(001 002 001 003) }

        it 'returns the correct total' do
          expect(subject.total).to eq(73.76)
        end
      end
    end
  end
end
