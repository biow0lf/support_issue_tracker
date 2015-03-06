require 'rails_helper'

describe TicketsSearch do
  before(:each) do
    TicketsIndex.purge!
  end

  it 'should search ticket by its uid' do
    uid = 'ABC-4F-ABC-8D-ABC'
    create(:ticket, uid: uid)
    TicketsIndex.import
    search = TicketsSearch.new(uid).search
    expect(search.load.count).to eq(1)
    expect(search.load.first.uid).to eq(uid)
  end

  it 'should search ticket by summary' do
    summary = 'Testing summary'
    create(:ticket, summary: summary)
    TicketsIndex.import
    search = TicketsSearch.new(summary).search
    expect(search.load.count).to eq(1)
    expect(search.load.first.summary).to eq(summary)
  end

  it 'should search ticket by body' do
    body = 'Testing body'
    create(:ticket, body: body)
    TicketsIndex.import
    search = TicketsSearch.new(body).search
    expect(search.load.count).to eq(1)
    expect(search.load.first.body).to eq(body)
  end
end
