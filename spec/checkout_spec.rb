require_relative '../checkout'

RSpec.describe Checkout do
  subject { described_class.new }

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

    context 'when there are zero items in checkout' do
      it 'returns 0' do
        expect(subject.total).to eq(0)
      end
    end

    context 'when there is one of each product' do
      before do
        subject.scan(sku: '001')
        subject.scan(sku: '002')
        subject.scan(sku: '003')
      end

      it 'returns the sum of each product' do
        expect(subject.total).to eq(66.78)
      end
    end
  end
end
