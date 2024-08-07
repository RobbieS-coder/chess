# frozen_string_literal: true

require_relative 'piece'

# Represents the bishop piece and its movement
class Bishop < Piece
  def symbol
    unicode_symbol("\u265d", "\u2657")
  end

  def abbrev
    'b'
  end

  private

  def in_possible_destinations?(squares, _captured)
    directions = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    straight_line_in_possible_destinations?(squares, directions)
  end

  def unblocked_path?(squares, board)
    from, to = squares
    diagonal_unblocked_path?(from, to, board)
  end
end
