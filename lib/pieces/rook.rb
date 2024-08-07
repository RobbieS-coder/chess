# frozen_string_literal: true

require_relative 'piece'

# Represents the rook piece and its movement
class Rook < Piece
  def symbol
    unicode_symbol("\u265c", "\u2656")
  end

  def abbrev
    'r'
  end

  def possible_destinations(from, board, _captured)
    directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]
    straight_line_possible_destinations(from, directions).filter { |dest| vert_hor_unblocked_path?(from, dest, board) }
  end
end
