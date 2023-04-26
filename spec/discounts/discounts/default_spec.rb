# frozen_string_literal: true

RSpec.describe Discounts::Default do
  describe '.discount_value' do
    it 'returns 0.0' do
      decorated_cart_item = instance_double(CartItemDecorator)
      expect(described_class.discount_value(decorated_cart_item)).to eq(0.0)
    end
  end
end
