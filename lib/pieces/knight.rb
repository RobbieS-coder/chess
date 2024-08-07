# frozen_string_literal: true

require_relative 'piece'

# Represents the knight piece and its movement
class Knight < Piece
  def symbol
    unicode_symbol("\u265e", "\u2658")
  end

  def abbrev
    'n'
  end

  def possible_destinations(from, _board, _captured)
    rank, file = from
    offsets = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]
    destinations = offsets.map { |rank_change, file_change| [rank + rank_change, file + file_change] }
    destinations.filter { |new_rank, new_file| new_rank.between?(0, 7) && new_file.between?(0, 7) }
  end
end
