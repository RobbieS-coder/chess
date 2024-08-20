# frozen_string_literal: true

# Contains methods that regulate the game's rules
module GameRules
  def in_check?(colour, board = @game_board)
    opposition_colour = colour == 'white' ? 'black' : 'white'
    all_possible_destinations(opposition_colour, board).any? { |rank, file| board[rank][file] == king(colour) }
  end

  private

  def legal_move?(after_board, colour, captured)
    return false if in_check?(colour, after_board)
    return legal_special_move?(captured, colour) if captured&.match?(/[EcC]/)

    true
  end

  def legal_special_move?(move_type, colour)
    move_type&.match?(/[cC]/) ? legal_castling?(move_type, colour) : legal_en_passant?(move_type)
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

  def all_possible_destinations(colour, board)
    all_possible_destinations = []
    board.each_with_index do |row, rank_index|
      row.each_with_index do |piece, file_index|
        next if piece.nil? || piece.colour != colour

        all_possible_destinations += piece.possible_destinations([rank_index, file_index], abbrev_board(board), 'k')
      end
    end
    all_possible_destinations
  end
end
