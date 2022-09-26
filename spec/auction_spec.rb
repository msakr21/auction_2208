require 'rspec'
require 'date'
require './lib/item'
require './lib/attendee'
require './lib/auction'

RSpec.describe Auction do
  let(:auction) {Auction.new}
  let(:item1) {Item.new('Chalkware Piggy Bank')}
  let(:item2) {Item.new('Bamboo Picture Frame')}
  let(:item3) {Item.new('Homemade Chocolate Chip Cookies')}
  let(:item4) {Item.new('2 Days Dogsitting')}
  let(:item5) {Item.new('Forever Stamps')}
  let(:attendee1) {Attendee.new({name: 'Megan', budget: '$50'})}
  let(:attendee2) {Attendee.new({name: 'Bob', budget: '$75'})}
  let(:attendee3) {Attendee.new({name: 'Mike', budget: '$100'})}

  it "1.exists" do
    expect(auction).to be_a(Auction)
  end

  it "2. has readable array attribute 'items' that is blank by default" do
    expect(auction.items).to eq([])
  end

  it "3. can add an item to 'items'" do
    expect(auction.items).to eq([])
    auction.add_item(item1)
    auction.add_item(item2)
    expect(auction.items).to eq([item1, item2])
  end

  it "4. can list the name of items" do
    auction.add_item(item1)
    auction.add_item(item2)
    expect(auction.item_names).to eq(['Chalkware Piggy Bank', 'Bamboo Picture Frame'])
  end

  it "5. can list unpopular items that have no bids on them" do
    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)
    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)
    item4.add_bid(attendee3, 50)

    expect(auction.unpopular_items).to eq([item2, item3, item5])
    item3.add_bid(attendee2, 15)
    expect(auction.unpopular_items).to eq([item2, item5])
  end

  it "6. can calculate potential revenue" do
    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)
    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)

    expect(auction.potential_revenue).to eq(87)
  end

  it "7. can list bidders" do
    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)
    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)

    expect(auction.bidders).to include("Megan", "Bob", "Mike")
  end

  it "8. can list bidders and their information" do
    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)
    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)

    expect(auction.bidder_info).to eq({
                                       attendee1 =>
                                          {
                                            :budget => 50,
                                            :items => [item1]
                                          },
                                       attendee2 =>
                                          {
                                            :budget => 75,
                                            :items => [item1, item3]
                                          },
                                        attendee3 =>
                                          {
                                            :budget => 100,
                                            :items => [item4]
                                          }
                                        })
  end

  it "9. creates participants info" do
    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)
    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)

    expect(auction.create_participants_info).to eq({
                                       attendee1 =>
                                          {
                                            :budget => 50,
                                            :items => []
                                          },
                                       attendee2 =>
                                          {
                                            :budget => 75,
                                            :items => []
                                          },
                                        attendee3 =>
                                          {
                                            :budget => 100,
                                            :items => []
                                          }
                                        })
  end

  it "10. adds items to bidders' bid items list" do
    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)
    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)

    auction.bidders_add_items
    expect(attendee1.items_bid).to eq([item1])
    expect(attendee2.items_bid).to eq([item1, item3])
    expect(attendee3.items_bid).to eq([item4])
  end

  it "11. can close auction" do
    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)
    item1.add_bid(attendee1, 22)
    item1.add_bid(attendee2, 20)
    item4.add_bid(attendee2, 30)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)
    item5.add_bid(attendee1, 35)

    expect(auction.close_auction).to eq({item1 => attendee1, item2 => "Not Sold", item4 => attendee3, item3 => attendee2, item5 => attendee1})
  end
end
