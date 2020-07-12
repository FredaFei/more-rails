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
  context 'index' do
    it '获取record失败' do
      get "/records"
      expect(response.status).to eq 401
    end
    it '删除record成功' do
      sign_in
      (1...12).to_a.map do
        Record.create! amount: 10000, category: 'outgoings'
      end
      get "/records"
      expect(response.status).to eq 200
      body = JSON.parse response.body
      expect(body['resources'].length).to eq 10
    end
  end
  context 'get' do
    it '获取一个record失败' do
      record = Record.create! amount: 10000, category: 'outgoings'
      get "/records/#{record.id}"
      expect(response.status).to eq 401
    end
    it '获取一个record成功' do
      sign_in
      record = Record.create! amount: 10000, category: 'outgoings'
      get "/records/#{record.id}"
      expect(response.status).to eq 200
    end
    it '获取一个不存在的record' do
      sign_in
      get "/records/999999999999"
      expect(response.status).to eq 404
    end
  end
end
