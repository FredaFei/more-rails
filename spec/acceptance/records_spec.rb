require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "records" do
  let(:record) { Record.create! amount: 10000, category: 'outgoings' }
  let(:id) { record.id }
  let(:amount) { 10000 }
  let(:category) { 'outgoings' }
  let(:notes) { '吃饭' }

  post "/records" do
    parameter :amount, '金额', type: :integer, required: true
    parameter :category, '类型: 1 outgoings|2 income', type: :string, required: true
    parameter :notes, '备注', type: :string
    example "创建记录" do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end

  delete "/records/:id" do
    example "删除记录" do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end

  get "/records" do
    parameter :page, '页码', type: :integer
    let(:page) { 1 }
    (1...12).to_a.map do
      Record.create! amount: 10000, category: 'outgoings'
    end
    example "获取所有记录" do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end
  get "/records/:id" do
    example "获取一个记录" do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end

  patch "/records/:id" do
    parameter :amount, '金额', type: :integer
    parameter :category, '类型: 1 outgoings|2 income', type: :string
    parameter :notes, '备注', type: :string
    example "更新一个记录" do
      sign_in
      do_request amount: 8800
      expect(status).to eq 200
    end
  end
end