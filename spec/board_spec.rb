require 'rspec'
require 'spec_helper'

describe Board, "#get_in_progress_total_size" do

  it 'should return 0 if no cards in progress' do
    b = Board.new([], [])
    b.get_in_progress_total_size.should eq 0
  end

  it 'should return 1 if one card in progress with size of 1' do
    in_progress_card = Card.new(1)
    b = Board.new([in_progress_card], [])
    b.get_in_progress_total_size.should eq 1
  end

  it 'should return 3 if three cards in progress with size of 1' do
    in_progress_card = Card.new(1)
    b = Board.new([in_progress_card, in_progress_card, in_progress_card], [])
    b.get_in_progress_total_size.should eq 3
  end
end

describe Board, "#get_complete_total_size" do
  it 'should return 0 if no cards in progress' do
    b = Board.new([],[])
    b.get_complete_total_size.should eq 0
  end

  it 'should return 2 if one card in progress with size of 2' do
    complete_card = Card.new(2)
    b = Board.new([], [complete_card])
    b.get_complete_total_size.should eq 2
  end

  it 'should return 6 if three cards in progress with size of 2' do
    complete_card = Card.new(2)
    b = Board.new([], [complete_card, complete_card, complete_card])
    b.get_complete_total_size.should eq 6
  end
end