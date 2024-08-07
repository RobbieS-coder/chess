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

  def possible_destinations(from, board, _captured)
    directions = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    straight_line_possible_destinations(from, directions).filter { |dest| diagonal_unblocked_path?(from, dest, board) }
  end
end
