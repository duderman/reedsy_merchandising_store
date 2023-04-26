# frozen_string_literal: true

RSpec.describe CartItemDecorator do
  subject { described_class.new(store_item, quantity) }

  let(:store_item) { build(:store_item, :mug, price: 25.50) }
  let(:quantity) { 2 }

  its(:code) { is_expected.to eq(store_item.code) }
  its(:name) { is_expected.to eq(store_item.name) }
  its(:price) { is_expected.to eq(25.50) }
  its(:total) { is_expected.to eq(51.00) }
end
