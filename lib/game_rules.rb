# frozen_string_literal: true

# Contains methods that regulate the game's rules
module GameRules
  def in_check?(colour)
    king = (colour == 'white' ? @white_king : @black_king)
    all_possible_destinations(colour).any? { |rank, file| @game_board[rank][file] == king }
  end

  private

  def legal_move?(before_board, after_board); end

  def all_possible_destinations(colour)
    all_possible_destinations = []
    @game_board.each_with_index do |row, rank_index|
      row.each_with_index do |piece, file_index|
        next if piece.nil? || piece.colour == colour

        all_possible_destinations += piece.possible_destinations([rank_index, file_index], abbrev_board, 'k')
      end
    end
    all_possible_destinations
  end
end
