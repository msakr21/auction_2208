class Item
  attr_reader :name,
              :bids,
              :bid_close

  def initialize(name)
    @name = name
    @bids = Hash.new(0)
    @bid_close = false
  end

  def add_bid(attendee, bid)
    (@bids[attendee] = bid) if bid_closed? == false
  end

  def current_high_bid
    bids.values.max
  end

  def bid_closed?
    bid_close
  end

  def close_bidding
    @bid_close = true
  end
end