# frozen_string_literal: true

# Keeps track of the moves made and
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

  def pawn_double_step_last_turn?(start_rank_index, end_rank_index, file_index)
    return false unless (start_rank_index - end_rank_index).abs == 2

    start_rank = (8 - start_rank_index).to_s
    end_rank = (8 - end_rank_index).to_s
    file = ('a'.ord + file_index).chr

    @history.last == (file + start_rank + file + end_rank)
  end

  def castling_pieces_moved?(castling_type, start_rank_index)
    start_rank = 8 - start_rank_index
    rook_file = castling_type == 'c' ? 'h' : 'a'
    king_position = "e#{start_rank}"
    rook_position = "#{rook_file}#{start_rank}"

    @history.any? { |move| move.start_with?(king_position) || move.start_with?(rook_position) }
  end

  def serialised_history
    Marshal.dump(@history)
  end
end
