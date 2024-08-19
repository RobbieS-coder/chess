# frozen_string_literal: true

require_relative 'piece'

# Represents the king piece and its movement
class King < Piece
  def initialize(colour)
    super(colour)
    @start_rank = @colour == 'white' ? 7 : 0
  end

  def symbol
    unicode_symbol("\u265a", "\u2654")
  end

  def abbrev
    'k'
  end

  def possible_destinations(from, _board, captured)
    rank, file = from
    return castling_possible_destinations(captured) if captured&.match?(/cC/)

    destinations = ((-1..1).to_a.product((-1..1).to_a) - [[0, 0]]).map { |dr, df| [rank + dr, file + df] }
    destinations.filter { |new_rank, new_file| new_rank.between?(0, 7) && new_file.between?(0, 7) }
  end

  def castling_possible_destinations(castling_type)
    case castling_type
    when 'c' then [@start_rank, 6]
    when 'C' then [@start_rank, 2]
    end
  end
end
