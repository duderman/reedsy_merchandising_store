# frozen_string_literal: true

RSpec.describe 'Store' do
  subject { response }

  let(:mug) { create(:store_item, :mug) }
  let(:tshirt) { create(:store_item, :tshirt) }
  let(:hoodie) { create(:store_item, :hoodie) }

  describe 'GET /' do
    before do
      mug && tshirt && hoodie
      get '/store'
    end

    it { is_expected.to be_successful }

    its(:body) do
      is_expected.to eq({ store_items: [
        { code: 'MUG', name: 'Reedsy Mug', price: '6.0' },
        { code: 'TSHIRT', name: 'Reedsy T-Shirt', price: '15.0' },
        { code: 'HOODIE', name: 'Reedsy Hoodie', price: '20.0' }
      ] }.to_json)
    end
  end

  describe 'PATCH /store/:code' do
    let(:params) { { store_item: store_item_params } }
    let(:store_item_params) { { name: 'New name', price: '10.0' } }

    before { patch "/store/#{mug.code}", params: }

    it { is_expected.to be_successful }
    its(:body) { is_expected.to eq({ store_item: { code: mug.code }.merge(store_item_params) }.to_json) }

    it 'updates the store item' do
      mug.reload
      expect(mug.name).to eq('New name')
      expect(mug.price).to eq(10.0)
    end

    context 'when params are invalid' do
      let(:store_item_params) { { name: '', price: 10.0 } }

      it { is_expected.to have_http_status(:unprocessable_entity) }

      its(:body) { is_expected.to eq({ errors: { name: ["can't be blank"] } }.to_json) }
    end

    context 'when store item does not exist' do
      let(:mug) { Struct.new(:code).new('MISSING') }

      it { is_expected.to have_http_status(:not_found) }
      its(:body) { is_expected.to eq({ error: 'not_found' }.to_json) }
    end
  end

  describe 'GET /store/total' do
    # Taken from the task examples
    it 'responds with total with discounts' do
      get '/store/total', params: { cart: { items: { mug.code => 1, tshirt.code => 1, hoodie.code => 1 } } }
      expect(response.body).to eq({ total: 41.to_d }.to_json)
      expect(response).to be_successful

      get '/store/total', params: { cart: { items: { mug.code => 9, tshirt.code => 1 } } }
      expect(response.body).to eq({ total: 69.to_d }.to_json)

      get '/store/total', params: { cart: { items: { mug.code => 10, tshirt.code => 1 } } }
      expect(response.body).to eq({ total: 73.8.to_d }.to_json)

      get '/store/total', params: { cart: { items: { mug.code => 45, tshirt.code => 3 } } }
      expect(response.body).to eq({ total: 279.9.to_d }.to_json)

      get '/store/total', params: { cart: { items: { mug.code => 200, tshirt.code => 4, hoodie.code => 1 } } }
      expect(response.body).to eq({ total: 902.to_d }.to_json)
    end

    context 'with unknown codes' do
      before { get '/store/total', params: { cart: { items: { 'UNKNOWN' => 1 } } } }

      it { is_expected.to be_successful }
      its(:body) { is_expected.to eq({ total: 0.0.to_d }.to_json) }
    end

    context 'when calculator raises an error' do
      before do
        calculator = instance_double(CartTotalCalculatorService)
        allow(CartTotalCalculatorService).to receive(:new).and_return(calculator)
        allow(calculator).to receive(:call)
          .and_raise(CartTotalCalculatorService::UnknownItemError, 'Unknown item code: UNKNOWN')
        get '/store/total', params: { cart: { items: { 'MUG' => 1 } } }
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
      its(:body) { is_expected.to eq({ error: 'Unknown item code: UNKNOWN' }.to_json) }
    end
  end
end
