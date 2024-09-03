# frozen_string_literal: true

# Contains methods that regulate the game's rules
module GameRules
  def in_check?(colour, board = @game_board)
    opposition_colour = colour == 'white' ? 'black' : 'white'
    all_possible_destinations(opposition_colour, ['k'], board).any? { |rank, file| board[rank][file] == king(colour) }
  end

  def game_over?(colour)
    all_valid_smith_moves(colour).empty?
  end

  def valid_draw?
    true
  end

  private

  def legal_move?(move, colour, captured)
    after_board = temp_board(move)
    return false if in_check?(colour, after_board)
    return legal_special_move?(move, captured, colour) if captured&.match?(/[EcC]/)

    true
  end

  def legal_special_move?(move, move_type, colour)
    move_type == 'E' ? legal_en_passant?(move) : legal_castling?(move_type, colour)
  end

  def legal_en_passant?(move)
    parsed_move = parse_move(move)
    from, to = parsed_move.values_at(:from, :to)
    from_rank = from.first
    to_file = to.last
    captured_piece = @game_board[from_rank][to_file]
    return false unless captured_piece.instance_of?(Pawn)
    return false unless @move_history.pawn_double_step_last_turn?(captured_piece.start_rank, from_rank, to_file)

    true
  end

  def legal_castling?(castling_type, colour)
    start_rank = king(colour).start_rank
    squares_between = (castling_type == 'c' ? [5, 6] : [1, 2, 3]).map { |file| [start_rank, file] }
    return false if squares_between.any? { |rank, file| @game_board[rank][file] }
    return false if @move_history.castling_pieces_moved?(castling_type, start_rank)
    return false if castling_temp_boards(castling_type, start_rank).any? { |board| in_check?(colour, board) }

    true
  end

  def castling_temp_boards(castling_type, start_rank)
    [temp_board(from_coords([start_rank, 4]) + from_coords([start_rank, (castling_type == 'c' ? 5 : 3)])), temp_board]
  end

  def all_possible_destinations(colour, captured, board)
    all_possible_moves(colour, captured, board).map(&:last)
  end

  def all_possible_moves(colour, captured, board = @game_board)
    all_possible_moves = []
    board.each_with_index do |row, rank_ind|
      row.each_with_index do |piece, file_ind|
        next if piece.nil? || piece.colour != colour

        dests = []
        captured.each { |capt| dests += piece.possible_destinations([rank_ind, file_ind], abbrev_board(board), capt) }
        dests.each { |dest| all_possible_moves << [[rank_ind, file_ind], dest] }
      end
    end
    all_possible_moves.uniq
  end

  def all_valid_smith_moves(colour)
    moves = all_possible_moves(colour, ['k', nil])
    smith_moves = moves.map { |from, to| from_coords(from) + from_coords(to) + abbrev_board[to.first][to.last].to_s }
    smith_moves.filter { |move| valid_move?(move, colour) }
  end
end
