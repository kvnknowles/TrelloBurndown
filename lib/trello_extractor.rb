require 'board'
require 'trello_wrapper'

class TrelloExtractor

  def load_board(name)
    in_progress_cards = TrelloWrapper.get_cards(name, 'In Progress')
    complete_cards = TrelloWrapper.get_cards(name, 'Complete')

    in_progress_list = load_cards(in_progress_cards)
    complete_list = load_cards(complete_cards)

    board = Board.new(in_progress_list, complete_list)
    board
  end

  def load_cards(cards)
    card_list = Array.new()
    cards.each do |card|
      size = get_size(card.name)
      card_list.push(Card.new(size))
    end
    card_list
  end

  def get_size(card_name)
    match = card_name.match(/.*(\d+)/)
    size = -1
    if match
      size = match[1].to_i
    end
    size
  end
end