# frozen_string_literal: true

RSpec.describe 'Root route' do
  it 'routes to the store items index' do
    expect(get: '/').to route_to('store#index')
  end
end
