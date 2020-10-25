require 'rails_helper'

RSpec.describe Session, type: :model do
  it '创建时必须有email' do
    session = Session.new password: '123456'
    session.validate
    expect(session.errors.details[:email][0][:error]).to eq :blank
  end
  it '创建时email为空，则只提示邮箱不能为空' do
    session = Session.new email: '', password: '123456'
    session.validate
    expect(session.errors.details[:email][0][:error]).to eq :blank
    expect(session.errors.details[:email][0].length).to eq 1
  end
  it '创建时email不含@，则只提示邮箱格式错误' do
    session = Session.new email: '1', password: '123456'
    session.validate
    expect(session.errors.details[:email][0][:error]).to eq :invalid
    expect(session.errors.details[:email].length).to eq 1
  end
  it '创建时密码为空，则只提示密码不能为空' do
    session = Session.new email: '1@qq.com', password: ''
    session.validate
    expect(session.errors.details[:password][0][:error]).to eq :blank
    expect(session.errors.details[:password][0].length).to eq 1
  end
  it '创建时密码最小长度为6' do
    session = Session.new email: '1@qq.com', password: '123'
    session.validate
    expect(session.errors.details[:password][0][:error]).to eq :too_short
    expect(session.errors.details[:password][0].length).to eq 2
    expect(session.errors.details[:password][0][:count]).to eq 6
  end
  it '创建时email必须注册过' do
    session = Session.new email: '1999999999999@qq.com', password: '123456'
    session.validate
    expect(session.errors.details[:email][0][:error]).to eq :not_found
  end
  it '创建时邮箱与密码不匹配' do
    user = User.create! email: '123@qq.com', password: '123123', password_confirmation: '123123'
    session = Session.new email: user[:email], password: '123456'
    session.validate
    expect(session.errors.details[:password][0][:error]).to eq :mismatch
  end

end