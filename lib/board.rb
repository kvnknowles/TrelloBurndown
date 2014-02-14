require_relative 'card'

class Board
  def initialize(in_progress, complete = [])
    @cards = Hash.new { |hash,key| hash[key] = [] }
    in_progress.each { |card| @cards[card.list] << card }
    complete.each { |card| @cards[card.list] << card }
  end

  def get_in_progress_total_size
    calculate_total_size(@cards[:in_progress])
  end

  def get_complete_total_size
    calculate_total_size(@cards[:complete])
  end

  def get_total_size
    calculate_total_size(@cards.values.flatten)
  end

  def calculate_total_size(card_list)
    card_list.map(&:size).reduce(0, &:'+')
  end
end