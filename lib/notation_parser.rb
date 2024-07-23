# frozen_string_literal: true

# Parses a move that is written in Smith notation
module NotationParser
  private

  def parse_move(move)
    parsed_move = { from: convert_square(move.slice!(0..1)), to: convert_square(move.slice!(0..1)) }
    if /^[NBRQ]$/.match?(move)
      parsed_move[:promoted] = move
    else
      parsed_move[:captured] = move.slice!(0)
      parsed_move[:promoted] = move.slice!(0)
    end
    parsed_move
  end

  def convert_square(square)
    file = square[0]
    rank = square[1].to_i

    file_index = file.ord - 'a'.ord
    rank_index = 8 - rank

    [rank_index, file_index]
  end
end
