require 'rails_helper'

RSpec.describe "Records", type: :request do
  it '创建record' do
    post '/records', params: {amount: 10000, category: 'outgoings', notes: '吃饭'}
    expect(response.status).to eq 200
    body = JSON.parse response.body
    expect(body['resource']['id']).to be
  end
end
