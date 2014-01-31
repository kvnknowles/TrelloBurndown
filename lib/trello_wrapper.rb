require 'trello'

include Trello
include Trello::Authorization

class TrelloWrapper
  Trello::Authorization.const_set :AuthPolicy, OAuthPolicy

  token = 'token'
  private_key = 'privateKey'
  public_key = 'publicKey'

  credential = OAuthCredential.new public_key, private_key
  OAuthPolicy.consumer_credential = credential

  OAuthPolicy.token = OAuthCredential.new token, nil

  def self.get_board(name)
    member = Member.find('me')
    board = member.boards.select { |board| board.name == name }.first
  end

  def self.get_list(board_name, list_name)
    board = get_board(board_name)
    board.lists.select { |list| list.name == list_name }.first
  end

  def self.get_cards(board_name, list_name)
    get_list(board_name, list_name).cards
  end
end