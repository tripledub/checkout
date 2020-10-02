require_relative '../checkout'

RSpec.describe Checkout do
  subject { described_class.new }

  describe ':total' do
    context 'when there are zero items in checkout' do
      it 'returns 0' do
        expect(subject.total).to eq(0)
      end
    end
  end
end
