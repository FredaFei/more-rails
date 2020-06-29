require 'rails_helper'

RSpec.describe User, type: :model do
  it '创建后密码加密处理' do
    user = User.create email: '1@qq.com', password: '123456', password_confirmation: '123456'
    expect(user.password_digest).to_not eq '123456'
    expect(user.id).to be_a Numeric
  end
  it '创建时必须有email' do
    user = User.create password: '123456', password_confirmation: '123456'
    expect(user.errors.details[:email][0][:error]).to eq :blank
  end
  it '创建时email为空，则只提示邮箱不能为空' do
    user = User.create email: '', password: '123456', password_confirmation: '123456'
    expect(user.errors.details[:email][0][:error]).to eq :blank
    expect(user.errors.details[:email][0].length).to eq 1
  end
  it '创建时密码为空，则只提示密码不能为空' do
    user = User.create email: '1@qq.com', password: '', password_confirmation: '123456'
    expect(user.errors.details[:password][0][:error]).to eq :blank
    expect(user.errors.details[:password][0].length).to eq 1
  end
  it '创建时密码最小长度为6' do
    user = User.create email: '1@qq.com', password: '123'
    expect(user.errors.details[:password][0][:error]).to eq :too_short
    expect(user.errors.details[:password][0].length).to eq 2
    expect(user.errors.details[:password][0][:count]).to eq 6
  end
  it '创建时确认密码与密码不匹配' do
    user = User.create email: '1@qq.com', password: '123123', password_confirmation: '123456'
    expect(user.errors.details[:password_confirmation][0][:error]).to eq :confirmation
    expect(user.errors.details[:password_confirmation][0][:attribute]).to eq 'Password'
    expect(user.errors.details[:password_confirmation][0].length).to eq 2
  end
  it '创建时email必须唯一' do
    User.create! email: '1@qq.com', password: '123456', password_confirmation: '123456'
    user = User.create email: '1@qq.com', password: '123456', password_confirmation: '123456'
    expect(user.errors.details[:email][0][:error]).to eq :taken
  end
  it '创建之后发注册成功邮件' do
    mailer = spy('mailer')
    allow(UserMailer).to receive(:welcome_email).and_return(mailer)
    User.create! email: '1@qq.com', password: '123456', password_confirmation: '123456'
    expect(UserMailer).to have_received(:welcome_email)
    expect(mailer).to have_received(:deliver_later)
  end

end
