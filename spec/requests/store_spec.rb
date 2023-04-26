# frozen_string_literal: true

RSpec.describe 'Store' do
  subject { response }

  describe 'GET /' do
    before do
      create(:store_item)
      create(:store_item, :tshirt)
      create(:store_item, :hoodie)

      get '/store'
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

  describe 'PATCH /store/:code' do
    let!(:store_item) { create(:store_item, code: 'MUG') }
    let(:params) { { store_item: store_item_params } }
    let(:store_item_params) { { name: 'New name', price: 10.0 } }

    before { patch '/store/MUG', params: }

    it { is_expected.to be_successful }

    it 'updates the store item' do
      store_item.reload
      expect(store_item.name).to eq('New name')
      expect(store_item.price).to eq(10.0)
    end

    context 'when params are invalid' do
      let(:store_item_params) { { name: '', price: 10.0 } }

      it { is_expected.to have_http_status(:unprocessable_entity) }

      its(:body) { is_expected.to eq({ errors: { name: ["can't be blank"] } }.to_json) }
    end

    context 'when store item does not exist' do
      let(:store_item) { nil }

      it { is_expected.to have_http_status(:not_found) }
    end
  end
end
