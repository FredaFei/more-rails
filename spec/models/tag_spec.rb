require 'rails_helper'

RSpec.describe Tag, type: :model do
  it '创建时必传name' do
    tag = Tag.create
    expect(tag.errors.details[:name][0][:error]).to eq :blank
    expect(tag.errors.details[:name][0].length).to eq 1
  end
end
