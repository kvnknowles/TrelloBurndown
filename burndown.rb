class Burndown

  def initialize(board)
    @board = board
  end

  def get_current_csv_output
    in_progress_total_size = @board.get_in_progress_total_size
    complete_total_size = @board.get_complete_total_size

    output = '"%s",%d,%d\n' % [Time.now.to_s, in_progress_total_size, complete_total_size]
    output
  end
end
