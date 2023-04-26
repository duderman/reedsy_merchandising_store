# frozen_string_literal: true

RSpec.describe Discounts::Mug do
  let(:dummy_item_class) do
    Class.new(Struct.new(:quantity)) do
      def total
        6.to_d * quantity
      end
    end
  end

  describe '.discount_value' do
    it 'correctly calculates discount value' do
      expect(described_class.discount_value(dummy_item_class.new(0))).to eq(0.0)
      expect(described_class.discount_value(dummy_item_class.new(1))).to eq(0.0)
      expect(described_class.discount_value(dummy_item_class.new(9))).to eq(0.0)
      expect(described_class.discount_value(dummy_item_class.new(10))).to eq(1.2)
      expect(described_class.discount_value(dummy_item_class.new(19))).to eq(2.28)
      expect(described_class.discount_value(dummy_item_class.new(20))).to eq(4.8)
      expect(described_class.discount_value(dummy_item_class.new(29))).to eq(6.96)
    end

    it 'maxes out at 30%' do
      expect(described_class.discount_value(dummy_item_class.new(149))).to eq(250.32)
      expect(described_class.discount_value(dummy_item_class.new(150))).to eq(270.0)
      expect(described_class.discount_value(dummy_item_class.new(151))).to eq(271.8)
    end
  end
end
