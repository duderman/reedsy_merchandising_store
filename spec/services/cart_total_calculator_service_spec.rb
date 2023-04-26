# frozen_string_literal: true

RSpec.describe CartTotalCalculatorService do
  let(:service) { described_class.new(cart_items) }

  let(:mug) { create(:store_item, :mug) }
  let(:tshirt) { create(:store_item, :tshirt) }
  let(:hoodie) { create(:store_item, :hoodie) }

  let(:cart_items) { { mug.code => 1, tshirt.code => 2, hoodie.code => 3 } }

  describe '#call' do
    subject(:call) { service.call }

    it { is_expected.to eq(96.0) }

    context 'when cart is empty' do
      let(:cart_items) { {} }

      it { is_expected.to eq(0.0) }
    end

    context 'when some items are unknown' do
      let(:cart_items) { { 'UNKNOWN' => 1 } }

      it 'raises an error' do
        expect { call }.to raise_error(CartTotalCalculatorService::UnknownItemError, 'Unknown item with code: UNKNOWN')
      end
    end

    context 'when discounts apply' do
      let(:cart_items) { { mug.code => 10 } }

      it 'uses total with discount' do
        expect(call).to eq(58.8)
      end
    end
  end
end
