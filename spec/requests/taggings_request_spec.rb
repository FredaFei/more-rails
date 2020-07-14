require 'rails_helper'

RSpec.describe "Taggings", type: :request do
  before :each do
    @tag = Tag.create! name: 'test'
    @record = Record.create! amount: 10000, category: 'income'
    @tagging = Tagging.create record: @record, tag: @tag
    (1..10).to_a.map do |n|
      Tagging.create! record: @record, tag: Tag.create!(name: "test#{n}")
    end
  end

  context 'create' do
    it '未登录时，创建tagging失败' do
      post '/taggings'
      expect(response.status).to eq 401
    end
    it '登录后，创建taggings' do
      sign_in
      post '/taggings', params: { record_id: @record.id, tag_id: @tag.id }
      expect(response.status).to eq 200
      body = JSON.parse response.body
      expect(body['resource']['id']).to be
    end
    it '登录后，创建taggings必传 record_id' do
      sign_in
      post '/taggings', params: { tag_id: @tag.id }
      expect(response.status).to eq 422
      body = JSON.parse response.body
      expect(body['errors']['record'][0]).to eq '记录不能为空'
    end
    it '登录后，创建taggings tag_id' do
      sign_in
      post '/taggings', params: { record_id: @record.id }
      expect(response.status).to eq 200
      body = JSON.parse response.body
      expect(body['errors']['tag'][0]).to eq '标签名不能为空'
    end
  end

  context 'destroy' do
    it '未登录时，删除taggings 失败' do
      delete "/taggings/#{@tagging.id}"
      expect(response.status).to eq 401
    end
    it '登录后，删除taggings 成功' do
      sign_in
      delete "/taggings/#{@tagging.id}"
      expect(response.status).to eq 200
    end
  end

  context 'index' do
    it '未登录时，获取taggings失败' do
      get "/taggings"
      expect(response.status).to eq 401
    end
    it '登录后，获取taggings成功' do
      sign_in
      get "/taggings"
      expect(response.status).to eq 200
      body = JSON.parse response.body
      expect(body['resources'].length).to eq 10
    end
  end

  context 'get' do
    it '未登录时，获取一个tagging失败' do
      get "/taggings/#{@tagging.id}"
      expect(response.status).to eq 401
    end
    it '登录后，获取一个tagging成功' do
      sign_in
      get "/taggings/#{@tagging.id}"
      expect(response.status).to eq 200
    end
    it '登录后，获取一个不存在的tagging' do
      sign_in
      get "/taggings/999999999999"
      expect(response.status).to eq 404
    end
  end

end
