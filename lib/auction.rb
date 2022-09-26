class Auction
  attr_reader :items,
              :date

  def initialize
    @items = []
    @date = ""
    set_date
  end

  def add_item(item)
    @items << item
  end

  def item_names
    items.map {|item| item.name}
  end

  def unpopular_items
    items.find_all {|item| item.bids == {}}
  end

  def potential_revenue
    popular_items = items - unpopular_items
    popular_items.sum {|popular_item| popular_item.current_high_bid}
  end

  def bidder_names
    items.map do |item|
      item.bids.keys.map do |attendee|
        attendee.name
      end
    end
  end

  def bidders
    bidder_names.flatten.uniq
  end

  def bidders_add_items
    items.map do |item|
      item.bids.keys.each do |attendee|
        attendee.items_bid << item
      end
    end
  end

  def create_participants_info
    participants = Hash.new(0)
      items.each do |item|
        item.bids.keys.each do |attendee|
          participants[attendee] = {budget: attendee.budget, items: attendee.items_bid}
        end
      end
    participants
  end

  def bidder_info
    bidders_add_items
    create_participants_info
  end

  def fill_conclusion(conclusion)
    items.each do |item|
      if item.bids != {}
        sell_item(conclusion, item)
      else
        conclusion[item] = "Not Sold"
      end
    end
  end

  def close_all_bids
    @items.each do |item|
      item.close_bidding
    end
  end

  def sell_item(conclusion, item)
    bid_amounts = item.bids.values
    loop do
      # require 'pry'; binding.pry
      if item.bids.key(item.current_high_bid).budget >= item.current_high_bid
        conclusion[item] = item.bids.key(item.current_high_bid)
        item.bids.key(item.current_high_bid).deduct_from_budget(item.current_high_bid)
        break
      elsif bid_amounts == []
        break
      else
        bid_amounts.delete(item.current_high_bid)
      end
    end
  end

  def close_auction
    close_all_bids
    conclusion = Hash.new(0)
    fill_conclusion(conclusion)
    conclusion
  end

  def set_date
    @date = Date.today.strftime "%d/%m/%Y"
  end
end