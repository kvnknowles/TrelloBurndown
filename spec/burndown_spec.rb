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
    expected_output = '"%s",%d,%d' % [mock_time, 1,1]
    burndown.get_current_csv_output.should eq expected_output
  end
end

describe Burndown, "#write_burndown_to_file", fakefs: true do
  it 'will write the header if output file does not exist' do
    board = Board.new([],[])

    burndown = Burndown.new(board)
    burndown.write_burndown_to_file("out.csv")

    File.read("out.csv").should start_with '"Reported","Doing","Done"'
  end

  it 'will not write the header if output file exists' do
    board = Board.new([],[])

    FileUtils.touch("out.csv")

    burndown = Burndown.new(board)
    burndown.write_burndown_to_file("out.csv")

    File.read("out.csv").should_not start_with '"Reported","Doing","Done"'
  end

  it 'will write the current csv output' do
    in_progress_card = Card.new(1)
    completed_card = Card.new(1)
    board = Board.new([in_progress_card], [completed_card])

    @time_now = Time.parse("Jan 18 2014")
    Time.stub(:now).and_return(@time_now)
    mock_time = Time.now

    burndown = Burndown.new(board)
    expected_output = '"%s",%d,%d' % [mock_time, 1,1]
    burndown.write_burndown_to_file("out.csv")
    File.read("out.csv").should include expected_output
  end

  it 'will append current csv output to end of existing file' do
    File.open("out.csv", 'w') do |f|
      f.puts("Initial")
    end

    in_progress_card = Card.new(1)
    completed_card = Card.new(1)
    board = Board.new([in_progress_card], [completed_card])

    @time_now = Time.parse("Jan 18 2014")
    Time.stub(:now).and_return(@time_now)
    mock_time = Time.now

    burndown = Burndown.new(board)
    expected_output = "Initial\n\"%s\",%d,%d\n" % [mock_time, 1,1]
    burndown.write_burndown_to_file("out.csv")
    File.read("out.csv").should eq expected_output
  end
end
