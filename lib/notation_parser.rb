# frozen_string_literal: true

# Parses a move that is written in Smith notation
module NotationParser
  private

  def parse_move(move)
    move = move.dup
    parsed_move = { from: to_coords(move.slice!(0..1)), to: to_coords(move.slice!(0..1)) }
    if /^[NBRQ]$/.match?(move)
      parsed_move[:promoted] = move
    else
      parsed_move[:captured] = move.slice!(0)
      parsed_move[:promoted] = move.slice!(0)
    end
    parsed_move
  end

  def to_coords(square)
    file = square[0]
    rank = square[1].to_i

    file_index = file.ord - 'a'.ord
    rank_index = 8 - rank

    [rank_index, file_index]
  end

  def from_coords(coords)
    rank_index = coords.first
    file_index = coords.last

    rank = (8 - rank_index).to_s
    file = ('a'.ord + file_index).chr

    file + rank
  end
end
