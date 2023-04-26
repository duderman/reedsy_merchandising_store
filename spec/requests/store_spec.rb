# frozen_string_literal: true

RSpec.describe 'Store' do
  subject { response }

  describe 'GET /' do
    before do
      create(:store_item)
      create(:store_item, :tshirt)
      create(:store_item, :hoodie)

      get '/'
    end

    it { is_expected.to be_successful }

    its(:body) do
      is_expected.to eq([
        { code: 'MUG', name: 'Reedsy Mug', price: '6.0' },
        { code: 'TSHIRT', name: 'Reedsy T-Shirt', price: '15.0' },
        { code: 'HOODIE', name: 'Reedsy Hoodie', price: '20.0' }
      ].to_json)
    end
  end
end
