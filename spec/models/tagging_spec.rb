require 'rails_helper'

RSpec.describe Tagging, type: :model do
  before :each do
    @user = create :user
  end

  it '创建时必传record' do
    tagging = build :tagging, record: nil
    tagging.validate

    expect(tagging.errors.details[:record][0][:error]).to eq :blank
    expect(tagging.errors.details[:record][0].length).to eq 1
  end

  it '创建时必传tag' do
    tagging = build :tagging, tag: nil
    tagging.validate
    expect(tagging.errors.details[:tag][0][:error]).to eq :blank
    expect(tagging.errors.details[:tag][0].length).to eq 1
  end

  it '创建时传tag & record 成功' do
    tag = create :tag
    record = create :record, user: @user
    create :tagging, record: record, tag: tag

    expect(tag.records.first.id).to eq record.id
    expect(record.tags.first.id).to eq tag.id
  end

  it '创建多个record & tag' do
    tag1 = create :tag
    tag2 = create :tag
    record1 = create :record
    record2 = create :record
    create :tagging, tag: tag1, record: record1
    create :tagging, tag: tag1, record: record2
    create :tagging, tag: tag2, record: record1
    create :tagging, tag: tag2, record: record2
    expect(tag1.records.count).to eq 2
    expect(tag2.records.count).to eq 2
    expect(record1.tags.count).to eq 2
    expect(record2.tags.count).to eq 2
  end
end
