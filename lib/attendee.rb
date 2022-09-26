class Attendee
  attr_reader :name,
              :budget

  attr_accessor :items_bid

  def initialize(attendee_info)
    @name = attendee_info[:name]
    length_of_budget = attendee_info[:budget].length - 1
    @budget = attendee_info[:budget][1..length_of_budget].to_i
    @items_bid= []
  end

end