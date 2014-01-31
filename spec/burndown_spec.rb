require 'rspec'
require 'spec_helper'
  
describe Burndown, "#get_current_csv_output" do

  let(:in_progress_card) { Card.new(1) }
  let(:completed_card) { Card.new(1) }
  let(:board) { Board.new([in_progress_card], [completed_card]) }
  let(:mock_time) {
    @time_now = Time.parse("Jan 18 2014 00:00:00 -0600")
    Time.stub(:now).and_return(@time_now)
    mock_time = Time.now
  }

  it 'populated board should output csv burndown' do
    expected_output = '"%s",%d,%d' % [mock_time, 1,1]
    Burndown.new(board).get_current_csv_output.should eq expected_output
  end
end

describe Burndown, "#write_burndown_to_file", fakefs: true do

  let(:in_progress_card) { Card.new(1) }
  let(:completed_card) { Card.new(1) }
  let(:board) { Board.new([in_progress_card], [completed_card]) }
  let(:empty_board) { Board.new([],[]) } 
  let(:mock_time) {
    @time_now = Time.parse("Jan 18 2014 00:00:00 -0600")
    Time.stub(:now).and_return(@time_now)
    mock_time = Time.now
  }
  let(:burndown_file) { "out.csv" }

  it 'will write the header if output file does not exist' do
    Burndown.new(empty_board).write_burndown_to_file(burndown_file)
    File.read(burndown_file).should start_with '"Reported","Doing","Done"'
  end

  it 'will not write the header if output file exists' do
    FileUtils.touch(burndown_file)
    Burndown.new(empty_board).write_burndown_to_file(burndown_file)
    File.read(burndown_file).should_not start_with '"Reported","Doing","Done"'
  end

  it 'will write the current csv output' do
    expected_output = '"%s",%d,%d' % [mock_time, 1,1]
    Burndown.new(board).write_burndown_to_file(burndown_file)
    File.read(burndown_file).should include expected_output
  end

  it 'will append current csv output to end of existing file' do
    File.open("out.csv", 'w') do |f|
      f.puts("Initial")
    end
    expected_output = "Initial\n\"%s\",%d,%d\n" % [mock_time, 1,1]
    Burndown.new(board).write_burndown_to_file(burndown_file)
    File.read(burndown_file).should eq expected_output
  end
end
