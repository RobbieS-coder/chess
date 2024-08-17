# frozen_string_literal: true

# Contains methods that regulate the game's rules
module GameRules
  def in_check?(colour, board = @game_board)
    king = (colour == 'white' ? @white_king : @black_king)
    opposition_colour = colour == 'white' ? 'black' : 'white'
    all_possible_destinations(opposition_colour).any? { |rank, file| board[rank][file] == king }
  end

  private

  def legal_move?(after_board, colour, captured)
    return false if in_check?(colour, after_board)

    true
  end

  def all_possible_destinations(colour)
    all_possible_destinations = []
    @game_board.each_with_index do |row, rank_index|
      row.each_with_index do |piece, file_index|
        next if piece.nil? || piece.colour != colour

        all_possible_destinations += piece.possible_destinations([rank_index, file_index], abbrev_board, 'k')
      end
    end
    all_possible_destinations
  end
end
