# frozen_string_literal: true

RSpec.describe Discounts do
  let(:mug) { build(:store_item, :mug) }
  let(:tshirt) { build(:store_item, :tshirt) }
  let(:hoodie) { build(:store_item, :hoodie) }

  # rubocop:disable RSpec/MessageSpies
  it 'applies discount according to item code' do
    expect(Discounts::Mug).to receive(:discount_value).with(mug)
    described_class.discount_value_for(mug)
    expect(Discounts::Tshirt).to receive(:discount_value).with(tshirt)
    described_class.discount_value_for(tshirt)
  end

  it 'calls default discount for non-configured items' do
    expect(Discounts::Default).to receive(:discount_value).with(hoodie)
    described_class.discount_value_for(hoodie)
  end
  # rubocop:enable RSpec/MessageSpies
end
