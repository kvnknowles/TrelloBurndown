require 'trello'

include Trello
include Trello::Authorization

class TrelloWrapper
  def initialize
    Trello::Authorization.const_set :AuthPolicy, OAuthPolicy

    token = 'token'
    private_key = 'private_key'
    public_key = 'public_key'

    credential = OAuthCredential.new public_key, private_key
    OAuthPolicy.consumer_credential = credential

    OAuthPolicy.token = OAuthCredential.new token, nil

    @member = Member.find('me')
  end

  def get_board(name)
    @member.boards.select { |board| board.name == name}.first
  end

  def get_list(board_name, list_name)
    board = get_board(board_name)
    board.select { |list| list.name == list_name }.first
  end

  def self.get_cards(board_name, list_name)
    get_list(board_name, list_name).cards
  end
end