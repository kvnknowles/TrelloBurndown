require "CSV"

class Burndown

  HEADER = ["Reported","Doing","Done"]

  def initialize(board)
    @board = board
  end

  def get_current_csv_output
    in_progress_total_size = @board.get_in_progress_total_size
    complete_total_size = @board.get_complete_total_size

    [Time.now.to_s, in_progress_total_size, complete_total_size]
  end

  def write_burndown_to_file(outputFile)
    output_file_exists = File.exists? outputFile
    CSV.open(outputFile, 'a') do |csv|
      csv << HEADER unless output_file_exists
      csv << get_current_csv_output
    end
  end

end
