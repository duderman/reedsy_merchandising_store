# frozen_string_literal: true

RSpec.describe StoreItemSerializer do
  let(:serializer) { described_class.new(store_item) }
  let(:store_item) { build(:store_item, :mug) }

  describe '#serializable_hash' do
    subject { serializer.serializable_hash }

    its([:code]) { is_expected.to eq store_item.code }
    its([:name]) { is_expected.to eq store_item.name }
    its([:price]) { is_expected.to eq store_item.price }
  end
end
