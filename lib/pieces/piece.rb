# frozen_string_literal: true

# Holds generic piece attributes to be inherited by specific piece classes
class Piece
  attr_reader :colour

  def initialize(colour)
    @colour = colour
  end

  def valid_standard_movement?(squares, board, captured)
    valid_move = in_possible_destinations?(squares, captured)
    valid_path = unblocked_path?(squares, board, captured) if [Bishop, Rook, Queen, Pawn].any? { |cl| instance_of?(cl) }
    puts "#{valid_move} #{valid_path}"
    valid_move && valid_path
  end

  private

  def unicode_symbol(white_symbol, black_symbol)
    @colour == 'white' ? white_symbol : black_symbol
  end
end
