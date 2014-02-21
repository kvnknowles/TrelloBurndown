require 'rspec'
require 'spec_helper'
require 'trello'
require 'trello_helper'

describe TrelloExtractor, '#load_board' do

  it 'should load all of the in progress cards' do
    foo_card = TrelloHelper.build_card_with_size('Foo', 1)
    bar_card = TrelloHelper.build_card_with_size('Bar', 2)

    TrelloWrapper.stub(:get_cards).with('Test Board', TrelloExtractor::IN_PROGRESS_LIST_NAME).and_return([foo_card, bar_card])
    TrelloWrapper.stub(:get_cards).with('Test Board', TrelloExtractor::COMPLETE_LIST_NAME).and_return([])

    trello = TrelloExtractor.new()
    board = trello.load_board('Test Board')
    board.get_in_progress_total_size.should eq 3
  end

  it 'should load all of the complete cards' do
    foo_card = TrelloHelper.build_card_with_size('Foo', 3)
    bar_card = TrelloHelper.build_card_with_size('Bar', 5)

    TrelloWrapper.stub(:get_cards).with('Test Board', TrelloExtractor::IN_PROGRESS_LIST_NAME).and_return([])
    TrelloWrapper.stub(:get_cards).with('Test Board', TrelloExtractor::COMPLETE_LIST_NAME).and_return([foo_card, bar_card])

    trello = TrelloExtractor.new()
    board = trello.load_board('Test Board')
    board.get_complete_total_size.should eq 8
  end
end

describe TrelloExtractor, '#get_size' do
  
  let(:default_size) { 100 }
  let(:settings_file_name) { 'settings.yml' }
  let(:trello_extractor) { TrelloExtractor.new(settings_file_name) }

  it 'should return one when one is in the name' do
    foo_card = TrelloHelper.build_card_with_size('Foo', 1)
    trello_extractor.get_size(foo_card.name).should eq 1
  end

  it 'should return default size when no size in the card name' do
    parsed_yaml = {
        'sizes' => Hash['default', default_size]
    }
    YAML.should_receive(:load_file).with(settings_file_name).and_return parsed_yaml
    card = TrelloHelper.build_card('foo')
    trello_extractor.get_size(card.name).should eq default_size
  end

  it 'should return 2 when {2} is in the card name' do
    card = TrelloHelper.build_card('Foo {2}')
    trello_extractor.get_size(card.name).should eq 2
  end

  it 'should return 3 when numbers exist in card name' do
    card = TrelloHelper.build_card('Foo 4 5 2 <3>')
    trello_extractor.get_size(card.name).should eq 3
  end

  it 'should return 4 when numbers before and after size' do
    card = TrelloHelper.build_card('Foo 3 2 [4] 23')
    trello_extractor.get_size(card.name).should eq 4
  end

  it 'should return correct size if sizes has a match' do
    card = TrelloHelper.build_card('Foo <S>')
    trello_extractor.instance_variable_set('@sizes', {'S' => 3})
    trello_extractor.get_size(card.name).should eq 3
  end

  it 'should return default size if sizes exist but does not match' do
    card = TrelloHelper.build_card('Bar <L>')
    size_hash = Hash.new(1)
    size_hash['S'] = 3
    SettingsLoader.stub(:load_sizes).and_return(size_hash)
    trello_extractor = TrelloExtractor.new()
    trello_extractor.get_size(card.name).should eq 1
  end

end