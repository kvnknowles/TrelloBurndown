require 'rspec'
require 'spec_helper'


describe Board, '#initialize' do

  let(:two_point_in_progress_card) { Card.new(2,:in_progress) }
  let(:two_point_completed_card) { Card.new(2,:complete) }


  it 'should accept zero arguments' do
    expect{ Board.new }.not_to raise_error
  end
  
  it 'will accept a single list of cards' do
    expect{ Board.new([]) }.not_to raise_error
  end

  describe 'will place the given cards in the correct lists' do

    it 'will put in_progress cards in the in_progress list' do
      Board.new([two_point_in_progress_card]).get_in_progress_total_size.should eq 2
    end

    it 'will put completed cards in the completed list' do
      Board.new([two_point_completed_card]).get_complete_total_size.should eq 2
    end

    it 'will put a mix of cards in the correct lists' do
      board = Board.new([two_point_completed_card,two_point_in_progress_card])
      board.get_complete_total_size.should eq 2
      board.get_in_progress_total_size.should eq 2
      board.get_total_size.should eq 4
    end

  end

  it 'should not accept two lists' do
    expect{ Board.new([], []) }.to raise_error(ArgumentError)
  end

end

describe Board, '#get_in_progress_total_size' do

  let(:empty_board) { Board.new }
  let(:in_progress_card) { Card.new(1, :in_progress) }
  let(:in_progress_cards) { [in_progress_card, in_progress_card, in_progress_card] }

  it 'should return 0 if no cards in progress' do
    empty_board.get_in_progress_total_size.should eq 0
  end

  it 'should return 1 if one card in progress with size of 1' do  
    Board.new([in_progress_card]).get_in_progress_total_size.should eq 1
  end

  it 'should return 3 if three cards in progress with size of 1' do
    Board.new(in_progress_cards).get_in_progress_total_size.should eq 3
  end
end

describe Board, '#get_complete_total_size' do

  let(:empty_board) { Board.new }
  let(:complete_card) { Card.new(2, :complete) }
  let(:in_progress_cards) { [] }
  let(:completed_cards) { [complete_card, complete_card, complete_card] }

  it 'should return 0 if no cards in progress' do
    empty_board.get_complete_total_size.should eq 0
  end

  it 'should return 2 if one card in progress with size of 2' do
    Board.new(in_progress_cards + [complete_card]).get_complete_total_size.should eq 2
  end

  it 'should return 6 if three cards in progress with size of 2' do
    Board.new(in_progress_cards + completed_cards).get_complete_total_size.should eq 6
  end
end

describe Board, '#get_total_size' do

  let(:empty_board) { Board.new }
  let(:one_point_backlog_card) { Card.new(1,:backlog) }
  let(:ten_point_backlog_card) { Card.new(10,:backlog) }
  let(:one_point_complete_card) { Card.new(1,:complete) }
  let(:three_point_in_progress_card) { Card.new(3,:in_progress) }
  let(:five_point_backlog_card) { Card.new(5,:backlog) }

  it 'should return 0 if no cards on board' do
    empty_board.get_total_size.should eq 0
  end

  it 'should return 1 if one card with size of 1' do
    Board.new([one_point_backlog_card]).get_total_size.should eq 1
  end

  it 'should return 10 if one card with size of 10' do
    Board.new([ten_point_backlog_card]).get_total_size.should eq 10
  end

  it 'should return 2 if two cards with size of 1 each' do
    Board.new([one_point_backlog_card,one_point_complete_card]).get_total_size.should eq 2
  end

  it 'should return 8 if two cards with size of 3 and 5' do
    Board.new([three_point_in_progress_card,five_point_backlog_card]).get_total_size.should eq 8
  end

  it 'should still know about in_progress' do
    Board.new([three_point_in_progress_card,five_point_backlog_card]).get_in_progress_total_size.should eq 3
  end

  it 'should still know about complte' do
    Board.new([one_point_backlog_card,one_point_complete_card]).get_complete_total_size.should eq 1
  end

end
