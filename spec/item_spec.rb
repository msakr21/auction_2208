require 'rspec'
require './lib/item'

RSpec.describe Item do
  let(:item1) {Item.new('Chalkware Piggy Bank')}
  let(:item2) {Item.new('Bamboo Picture Frame')}

  it "1. exists" do
    expect(item1).to be_a(Item)
    expect(item2).to be_a(Item)
  end

  it "2. has readable attribute 'name'" do
    expect(item1.name).to eq('Chalkware Piggy Bank')
    expect(item2.name).to eq('Bamboo Picture Frame')
  end
end