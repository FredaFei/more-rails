require 'rails_helper'

RSpec.describe Tagging, type: :model do
  it '创建时必传record' do
    tag = Tag.create! name: 'test'
    tagging = Tagging.create tag: tag
    expect(tagging.errors.details[:record][0][:error]).to eq :blank
    expect(tagging.errors.details[:record][0].length).to eq 1
  end

  it '创建时必传tag' do
    record = Record.create! amount: 10000, category: 'income'
    tagging = Tagging.create record: record
    expect(tagging.errors.details[:tag][0][:error]).to eq :blank
    expect(tagging.errors.details[:tag][0].length).to eq 1
  end

  it '创建时传tag & record 成功' do
    tag = Tag.create! name: 'test'
    record = Record.create! amount: 10000, category: 'income'
    tagging = Tagging.create record: record, tag: tag
    p tagging
    expect(tag.records.first.id).to eq record.id
    expect(record.tags.first.id).to eq tag.id
  end

  it '创建多个record & tag' do
    tag1 = Tag.create! name: 'test1'
    tag2 = Tag.create! name: 'test2'
    record1 = Record.create amount: 10000, category: 'income'
    record2 = Record.create amount: 10000, category: 'income'
    Tagging.create tag: tag1, record: record1
    Tagging.create tag: tag1, record: record2
    Tagging.create tag: tag2, record: record1
    Tagging.create tag: tag2, record: record2
    expect(tag1.records.count).to eq 2
    expect(tag2.records.count).to eq 2
    expect(record1.tags.count).to eq 2
    expect(record2.tags.count).to eq 2
  end
end
