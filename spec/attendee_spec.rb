require 'rspec'
require './lib/attendee'

RSpec.describe Attendee do
  let(:attendee) {Attendee.new({name: 'Megan', budget: '$50'})}

  it "1. exists" do
    expect(attendee).to be_a(Attendee)
  end

  it "2. has readable attributes 'name' and 'budget'" do
    expect(attendee.name).to eq("Megan")
    expect(attendee.budget).to eq(50)
  end

  it "3. has a readable and writable array attribute 'items_bid' that is blank by default" do
    expect(attendee.items_bid).to eq([])
    attendee.items_bid << 1
    expect(attendee.items_bid).to eq([1])
    attendee.items_bid << "7amada"
    expect(attendee.items_bid).to eq([1, "7amada"])
  end

end