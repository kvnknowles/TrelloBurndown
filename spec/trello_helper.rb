class TrelloHelper
  def self.build_card_with_size(name, size)
    trello_card = Trello::Card.new()
    trello_card.name = '%s [%d]' % [name, size]
    trello_card
  end

  def self.build_card(name)
    trello_card = Trello::Card.new()
    trello_card.name = name
    trello_card
  end

  def self.build_list(name)
    trello_list = Trello::List.new()
    trello_list.name = name
    trello_list
  end

  def self.build_board(name)
    trello_board = Trello::Board.new()
    trello_board.name = name
    trello_board
  end
end