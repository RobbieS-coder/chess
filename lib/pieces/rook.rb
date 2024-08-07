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

  private

  def in_possible_destinations?(squares, _captured)
    directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]
    straight_line_in_possible_destinations?(squares, directions)
  end

  def unblocked_path?(squares, board)
    from, to = squares
    vert_hor_unblocked_path?(from, to, board)
  end
end
