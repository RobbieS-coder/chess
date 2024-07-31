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

  private

  def in_possible_destinations?(squares, _captured)
    from, to = squares
    rank, file = from
    destinations = []
    (-1..1).each do |rank_change|
      (-1..1).each do |file_change|
        next if rank_change.zero? && file_change.zero?

        destinations << [rank + rank_change, file + file_change]
      end
    end
    destinations.include?(to)
  end
end
