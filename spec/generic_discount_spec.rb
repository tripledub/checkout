# frozen_string_literal: true

require_relative '../generic_discount'

RSpec.describe GenericDiscount do
  let(:discount_amount) { 10.0 }
  let(:discount_at) { 60 }
  let(:sumtotal) { 100 }

  subject do
    described_class.new(
      discount_amount: discount_amount,
      discount_at: discount_at
    ).discount(sumtotal: sumtotal)
  end

  describe ':discount' do
    context 'no change when the sumtotal is below the theshold' do
      let(:sumtotal) { discount_at - 1 }

      it { is_expected.to eq(sumtotal) }
    end

    context 'applies discount when the sumtotal is equal to the theshold' do
      let(:sumtotal) { discount_at }

      it { is_expected.to be < sumtotal }
    end

    context 'applies discount when the sumtotal is above the theshold' do
      let(:sumtotal) { discount_at + 1 }

      it { is_expected.to be < sumtotal }
    end
  end
end
