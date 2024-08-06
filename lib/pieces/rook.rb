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
    from, to = squares
    rank, file = from
    directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]
    destinations = directions.flat_map do |rank_change, file_change|
      (1..7).map { |i| [rank + i * rank_change, file + i * file_change] }
            .take_while { |new_rank, new_file| new_rank.between?(0, 7) && new_file.between?(0, 7) }
    end
    destinations.include?(to)
  end

  def unblocked_path?(squares, board)
    from, to = squares
    vert_hor_unblocked_path?(from, to, board)
  end
end
