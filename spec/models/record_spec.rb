require 'rails_helper'

RSpec.describe Record, type: :model do
  it '创建时必有email' do
    record = Record.create category: 'outgoings', notes: '吃饭'
    expect(record.errors.details[:amount][0][:error]).to eq :blank
    expect(record.errors.details[:amount][0].length).to eq 1
  end
  it '创建时必有password' do
    record = Record.create amount: 100000, notes: '吃饭'
    expect(record.errors.details[:category][0][:error]).to eq :blank
    expect(record.errors.details[:category][0].length).to eq 1
  end
  it '创建时category只能是 outgoings | income' do
    expect {
      Record.create amount: 100000, category: 'out', notes: '吃饭'
    }.to raise_error(ArgumentError)
  end


end