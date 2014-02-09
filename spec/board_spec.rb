require 'rspec'
require 'spec_helper'

describe Board, '#get_in_progress_total_size' do

  let(:empty_board) { Board.new([], []) }
  let(:in_progress_card) { Card.new(1) }
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
  let(:complete_card) { Card.new(2) }
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