require 'rails_helper'

RSpec.describe "Tags", type: :request do

  context 'create' do
    it '未登录时，创建tag失败' do
      post '/tags', params: { name: '吃饭' }
      expect(response.status).to eq 401
    end
    it '登录后，创建tags' do
      sign_in
      post '/tags', params: { name: '吃饭' }
      expect(response.status).to eq 200
      body = JSON.parse response.body
      expect(body['resource']['id']).to be
    end
  end

  context 'destroy' do
    it '未登录时，删除tag失败' do
      tag = Tag.create! name: 'test'
      delete "/tags/#{tag.id}"
      expect(response.status).to eq 401
    end
    it '登录后，删除tag成功' do
      sign_in
      tag = Tag.create! name: 'test'
      delete "/tags/#{tag.id}"
      expect(response.status).to eq 200
    end
  end

  context 'index' do
    it '未登录时，获取tags失败' do
      get "/tags"
      expect(response.status).to eq 401
    end
    it '登录后，获取tags成功' do
      sign_in
      (1...12).to_a.map do |n|
        Tag.create! name: "test#{n}"
      end
      get "/tags"
      expect(response.status).to eq 200
      body = JSON.parse response.body
      expect(body['resources'].length).to eq 10
    end
  end

  context 'get' do
    it '未登录时，获取一个tag失败' do
      tag = Tag.create! name: 'outgoings'
      get "/tags/#{tag.id}"
      expect(response.status).to eq 401
    end
    it '登录后，获取一个tag成功' do
      sign_in
      tag = Tag.create! name: 'outgoings'
      get "/tags/#{tag.id}"
      expect(response.status).to eq 200
    end
    it '登录后，获取一个不存在的tag' do
      sign_in
      get "/tags/999999999999"
      expect(response.status).to eq 404
    end
  end

  context 'update' do
    it '未登录时，更新一个tag失败' do
      tag = Tag.create! name: 'outgoings'
      patch "/tags/#{tag.id}"
      expect(response.status).to eq 401
    end
    it '登录后，更新一个tag成功' do
      sign_in
      tag = Tag.create! name: 'outgoings'
      patch "/tags/#{tag.id}", params: { name: 'out' }
      expect(response.status).to eq 200
      body = JSON.parse response.body
      expect(body['resource']['name']).to eq 'out'
    end
    it '登录后，更新一个不存在的tag' do
      sign_in
      patch "/tags/999999999999", params: { name: 'test' }
      expect(response.status).to eq 404
    end
  end

end
