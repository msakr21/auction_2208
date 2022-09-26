class Auction
  attr_reader :items

  def initialize
    @items = []
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
end