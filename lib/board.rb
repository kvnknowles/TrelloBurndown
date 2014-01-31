require 'card'

class Board
  def initialize(in_progress, complete)
    @in_progress = in_progress
    @complete = complete
  end

  def get_in_progress_total_size
    calculate_total_size(@in_progress)
  end

  def get_complete_total_size
    calculate_total_size(@complete)
  end

  def calculate_total_size(card_list)
    card_list.map { |card| card.size }.reduce(0) { |sum, size| sum + size }
  end
end