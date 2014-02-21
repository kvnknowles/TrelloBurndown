require_relative 'board'
require_relative 'trello_wrapper'
require_relative 'settings_loader'

class TrelloExtractor

  IN_PROGRESS_LIST_NAME = 'Doing'
  COMPLETE_LIST_NAME = 'Done'

  def initialize(settings_file = '')
    @sizes = SettingsLoader.load_sizes(settings_file)
  end

  def load_board(name)
    in_progress_cards = TrelloWrapper.get_cards(name, IN_PROGRESS_LIST_NAME)
    complete_cards = TrelloWrapper.get_cards(name, COMPLETE_LIST_NAME)

    in_progress_list = load_cards(in_progress_cards,:in_progress)
    complete_list = load_cards(complete_cards,:complete)

    Board.new(in_progress_list + complete_list)
  end

  def load_cards(cards,list)
    cards.map { |card| Card.new(get_size(card.name),list) }
  end

  ## disasterously ugly code, extract, isolate, and refactor
  def get_size(card_name)
    if @sizes
      begin
        size_key = /[<{\[](.+)[>}\]]/.match(card_name)[1].to_sym
        if @sizes.has_key? size_key
          size = @sizes[size_key]  
        else
          if size_key.to_s.to_i != 0
            size = size_key.to_s.to_i
          else
            size = @sizes[:default]
          end
        end
      rescue Exception => e
        size = @sizes[:default]
      end
    else
      size = (/[<{\[](\d+)[>}\]]/.match(card_name) || DEFAULT_SIZE )[1].to_i
    end
    size
  end
end