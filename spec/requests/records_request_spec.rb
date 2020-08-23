require 'rails_helper'

RSpec.describe "Records", type: :request do
  before :each do
    @user = create :user
  end

  context 'create' do
    it '未登录时，创建record失败' do
      post '/records', params: { amount: 10000, category: 'outgoings', notes: '吃饭' }
      expect(response.status).to eq 401
    end
    it '登录后，创建record' do
      sign_in
      post '/records', params: { amount: 10000, category: 'outgoings', notes: '吃饭' }
      expect(response.status).to eq 200
      body = JSON.parse response.body
      expect(body['resource']['id']).to be
    end
    it '登录后未传金额时，创建record失败' do
      sign_in
      post '/records', params: { category: 'outgoings', notes: '吃饭' }
      expect(response.status).to eq 422
      body = JSON.parse response.body
      expect(body['errors']['amount'][0]).to eq '金额不能为空'
    end
  end

  context 'destroy' do
    it '未登录时，删除record失败' do
      record = create :record
      delete "/records/#{record.id}"
      expect(response.status).to eq 401
    end
    it '登录后，删除record成功' do
      sign_in
      record = create :record
      delete "/records/#{record.id}"
      expect(response.status).to eq 200
    end
  end

  context 'index' do
    it '未登录时，获取records失败' do
      get "/records"
      expect(response.status).to eq 401
    end
    it '登录后，获取records成功' do
      (1...12).to_a.map do
        create :record
      end
      sign_in
      get "/records"
      expect(response.status).to eq 200
      body = JSON.parse response.body
      expect(body['resources'].length).to eq 10
    end
  end

  context 'get' do
    it '未登录时，获取一个record失败' do
      record = create :record
      get "/records/#{record.id}"
      expect(response.status).to eq 401
    end
    it '登录后，获取一个record成功' do
      sign_in
      record = create :record
      get "/records/#{record.id}"
      expect(response.status).to eq 200
    end
    it '登录后，获取一个不存在的record' do
      sign_in
      get "/records/999999999999"
      expect(response.status).to eq 404
    end
  end

  context 'update' do
    it '未登录时，更新一个record失败' do
      record = create :record, user: @user
      patch "/records/#{record.id}", params: { amount: 9.9 }
      expect(response.status).to eq 401
    end
    it '登录后，更新一个record成功' do
      sign_in
      record = create :record, user: @user
      patch "/records/#{record.id}", params: { amount: 8800 }
      expect(response.status).to eq 200
      body = JSON.parse response.body
      expect(body['resource']['amount']).to eq 8800
    end
    it '登录后，更新一个不存在的record' do
      sign_in
      patch "/records/999999999999", params: { amount: 8800 }
      expect(response.status).to eq 404
    end
  end

end
