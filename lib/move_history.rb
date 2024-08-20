# frozen_string_literal: true

# Keeps track of the moves made
class MoveHistory
  def initialize(history = [])
    @history = history
  end

  def add_move(move)
    @history << move
  end

  def recent_moves
    return @history[-8, 8] if @history.length >= 8

    @history
  end

  def castling_pieces_moved?(castling_type, start_rank_index)
    start_rank = 8 - start_rank_index
    rook_file = castling_type == 'c' ? 'h' : 'a'
    king_position = "e#{start_rank}"
    rook_position = "#{rook_file}#{start_rank}"

    @history.any? { |move| move.start_with?(king_position) || move.start_with?(rook_position) }
  end
end
