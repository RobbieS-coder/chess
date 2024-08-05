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

  private

  def in_possible_destinations?(squares, _captured)
    from, to = squares
    rank, file = from
    offsets = [
      [2, 1], [2, -1], [-2, 1], [-2, -1],
      [1, 2], [1, -2], [-1, 2], [-1, -2]
    ]
    destinations = offsets.map { |rank_change, file_change| [rank + rank_change, file + file_change] }
    destinations.include?(to)
  end
end
