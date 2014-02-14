require 'rspec'
require 'spec_helper'


describe Board, '#initialize' do

  it 'will accept a single list of cards' do
    expect{ Board.new([]) }.not_to raise_error
  end

  describe 'will place the given cards in the correct lists' do

    it 'will put in_progress cards in the in_progress list' do
      Board.new([Card.new(2, :in_progress)]).get_in_progress_total_size.should eq 2
    end

    it 'will put completed cards in the completed list' do
      Board.new([Card.new(2, :complete)]).get_complete_total_size.should eq 2
    end

    it 'will put a mix of cards in the correct lists' do
      board = Board.new([Card.new(2, :complete),Card.new(2, :in_progress)])
      board.get_complete_total_size.should eq 2
      board.get_in_progress_total_size.should eq 2
      board.get_total_size.should eq 4
    end

  end

  #characterize
  describe 'takes two lists, in_progress and complete' do

#    it 'should not accept only one list' do
#      expect{ Board.new([]) }.to raise_error(ArgumentError)
#    end

    it 'should not accept three lists' do
      expect{ Board.new([], [], []) }.to raise_error(ArgumentError)
    end

    it 'should accept two lists' do
      expect{ Board.new([],[]) }.not_to raise_error
    end

  end

end

describe Board, '#get_in_progress_total_size' do

  let(:empty_board) { Board.new([], []) }
  let(:in_progress_card) { Card.new(1, :in_progress) }
  let(:in_progress_cards) { [in_progress_card, in_progress_card, in_progress_card] }
  let(:completed_cards) { [] }

  it 'should return 0 if no cards in progress' do
    empty_board.get_in_progress_total_size.should eq 0
  end

  it 'should return 1 if one card in progress with size of 1' do  
    Board.new([in_progress_card], completed_cards).get_in_progress_total_size.should eq 1
  end

  it 'should return 3 if three cards in progress with size of 1' do
    Board.new(in_progress_cards, completed_cards).get_in_progress_total_size.should eq 3
  end
end

describe Board, '#get_complete_total_size' do

  let(:empty_board) { Board.new([], []) }
  let(:complete_card) { Card.new(2, :complete) }
  let(:in_progress_cards) { [] }
  let(:completed_cards) { [complete_card, complete_card, complete_card] }

  it 'should return 0 if no cards in progress' do
    empty_board.get_complete_total_size.should eq 0
  end

  it 'should return 2 if one card in progress with size of 2' do
    Board.new(in_progress_cards, [complete_card]).get_complete_total_size.should eq 2
  end

  it 'should return 6 if three cards in progress with size of 2' do
    Board.new(in_progress_cards, completed_cards).get_complete_total_size.should eq 6
  end
end

describe Board, '#get_total_size' do

  let(:empty_board) { Board.new([], []) }

  it 'should return 0 if no cards on board' do
    empty_board.get_total_size.should eq 0
  end

  it 'should return 1 if one card with size of 1' do
    Board.new([Card.new(1,:in_progress)],[]).get_total_size.should eq 1
  end

  it 'should return 10 if one card with size of 10' do
    Board.new([],[Card.new(10,:complete)]).get_total_size.should eq 10
  end

  it 'should return 2 if two cards with size of 1 each' do
    Board.new([Card.new(1,:in_progress)],[Card.new(1,:complete)]).get_total_size.should eq 2
  end

  it 'should return 8 if two cards with size of 3 and 5' do
    Board.new([Card.new(3,:in_progress)],[Card.new(5,:complete)]).get_total_size.should eq 8
  end

end
