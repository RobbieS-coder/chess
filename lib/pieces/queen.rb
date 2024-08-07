# frozen_string_literal: true

require_relative 'piece'

# Represents the queen piece and its movement
class Queen < Piece
  def symbol
    unicode_symbol("\u265b", "\u2655")
  end

  def abbrev
    'q'
  end

  def possible_destinations(from, board, _captured)
    directions = [[1, 1], [1, -1], [-1, 1], [-1, -1], [0, 1], [0, -1], [1, 0], [-1, 0]]
    straight_line_possible_destinations(from, directions).filter { |dest| unblocked_path?(from, dest, board) }
  end

  private

  def unblocked_path?(from, to, board)
    from_rank, from_file = from
    to_rank, to_file = to

    if from_rank == to_rank || from_file == to_file
      vert_hor_unblocked_path?(from, to, board)
    else
      diagonal_unblocked_path?(from, to, board)
    end
  end
end
