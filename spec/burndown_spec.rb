require 'rspec'
require 'spec_helper'

describe Burndown, "#get_current_csv_output" do

  it 'populated board should output csv burndown' do
    in_progress_card = Card.new(1)
    completed_card = Card.new(1)
    board = Board.new([in_progress_card], [completed_card])

    @time_now = Time.parse("Jan 18 2014")
    Time.stub(:now).and_return(@time_now)
    mock_time = Time.now

    burndown = Burndown.new(board)
    expected_output = '"%s",%d,%d\n' % [mock_time, 1,1]
    burndown.get_current_csv_output.should eq expected_output
  end
end
