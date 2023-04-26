# frozen_string_literal: true

RSpec.describe CartTotalCalculatorService do
  let(:service) { described_class.new(cart_items) }
  let(:cart_items) { { 'MUG' => 1, 'TSHIRT' => 2, 'HOODIE' => 3 } }

  before do
    create(:store_item, :mug)
    create(:store_item, :tshirt)
    create(:store_item, :hoodie)
  end

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
  end
end
