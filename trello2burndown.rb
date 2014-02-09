require 'trollop'
require_relative 'lib/trello_extractor'
require_relative 'lib/burndown'

opts = Trollop::options do
  version = 'trello2burndown 0.0.1'
  banner <<-EOS
trello2burndown converts a trello board into a csv

Usage:
  ruby trello2burndown.rb [options]
where [options] are:
  EOS
  opt :board_name, 'Board Name', :type => String, :required => true
  opt :output_file, 'Output File', :type => String, :default => 'out.csv'
end

board = TrelloExtractor.new().load_board(opts[:board_name])
Burndown.new(board).write_burndown_to_file(opts[:output_file])