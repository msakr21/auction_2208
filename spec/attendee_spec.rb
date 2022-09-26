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

end