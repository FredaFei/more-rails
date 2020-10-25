require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "session" do
  let(:user) { create :user, email: '145456@qq.com' }
  post "/sessions" do
    parameter :email, '邮箱', type: :string, required: true
    parameter :password, '密码', type: :string, required: true
    example "用户（登录）" do
      do_request(email: user.email, password: user.password)
      expect(status).to eq 200
    end
  end

  delete "/sessions" do
    example "退出登录" do
      do_request
      expect(status).to eq 200
    end
  end
end