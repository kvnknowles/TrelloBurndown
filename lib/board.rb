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
    total_size = 0
    card_list.each do |card|
      total_size += card.size
    end
    total_size
  end
end