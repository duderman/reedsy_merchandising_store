# frozen_string_literal: true

RSpec.describe CartItemDecorator do
  subject(:decorated_cart_item) { described_class.new(store_item, quantity) }

  let(:store_item) { build(:store_item, :mug, price: 25.50) }
  let(:quantity) { 2 }

  its(:code) { is_expected.to eq(store_item.code) }
  its(:name) { is_expected.to eq(store_item.name) }
  its(:price) { is_expected.to eq(25.50) }

  describe '#quantity' do
    subject { decorated_cart_item.quantity }

    it { is_expected.to be(2) }

    context 'when quantity is a string' do
      let(:quantity) { '2' }

      it { is_expected.to be(2) }
    end
  end

  describe '#total' do
    it 'returns price * quantity' do
      expect(decorated_cart_item.total).to eq(51.00)
    end
  end

  describe '#total_with_discount' do
    before { allow(Discounts).to receive(:discount_value_for).with(decorated_cart_item).and_return(10.0) }

    it 'returns total with discount applied' do
      expect(decorated_cart_item.total_with_discount).to eq(41.00)
    end
  end
end
