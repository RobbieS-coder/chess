# frozen_string_literal: true

require_relative 'piece'

# Represents the king piece and its movement
class King < Piece
  def symbol
    unicode_symbol("\u265a", "\u2654")
  end

  def abbrev
    'k'
  end

  def possible_destinations(from, _board, _captured)
    rank, file = from
    destinations = []
    (-1..1).each do |rank_change|
      (-1..1).each do |file_change|
        next if rank_change.zero? && file_change.zero?

        destinations << [rank + rank_change, file + file_change]
      end
    end
    destinations.filter { |new_rank, new_file| new_rank.between?(0, 7) && new_file.between?(0, 7) }
  end
end
