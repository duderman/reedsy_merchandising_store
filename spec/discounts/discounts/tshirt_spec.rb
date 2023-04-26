# frozen_string_literal: true

RSpec.describe Discounts::Tshirt do
  describe '.discount_value' do
    it 'returns 0 for less than 3 tshirts' do
      decorated_cart_item = instance_double(CartItemDecorator, quantity: 2, total: 100)
      expect(described_class.discount_value(decorated_cart_item)).to eq(0.0)
    end

    it 'adds 30% discount for 3 and more tshirts' do
      decorated_cart_item = instance_double(CartItemDecorator, quantity: 3, total: 100)
      expect(described_class.discount_value(decorated_cart_item)).to eq(30)
      decorated_cart_item = instance_double(CartItemDecorator, quantity: 5, total: 100)
      expect(described_class.discount_value(decorated_cart_item)).to eq(30)
    end
  end
end
