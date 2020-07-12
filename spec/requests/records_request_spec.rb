require 'rails_helper'

RSpec.describe "Records", type: :request do
  context 'create' do
    it '未登录时，创建record失败' do
      post '/records', params: { amount: 10000, category: 'outgoings', notes: '吃饭' }
      expect(response.status).to eq 401
    end
    it '创建record' do
      sign_in
      post '/records', params: { amount: 10000, category: 'outgoings', notes: '吃饭' }
      expect(response.status).to eq 200
      body = JSON.parse response.body
      expect(body['resource']['id']).to be
    end
    it '创建record失败' do
      sign_in
      post '/records', params: { category: 'outgoings', notes: '吃饭' }
      expect(response.status).to eq 422
      body = JSON.parse response.body
      expect(body['errors']['amount'][0]).to eq '金额不能为空'
    end
  end
  context 'destroy' do
    it '删除record失败' do
      record = Record.create! amount: 10000, category: 'outgoings'
      delete "/records/#{record.id}"
      expect(response.status).to eq 401
    end
    it '删除record成功' do
      sign_in
      record = Record.create! amount: 10000, category: 'outgoings'
      delete "/records/#{record.id}"
      expect(response.status).to eq 200
    end
  end
end