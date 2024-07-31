# frozen_string_literal: true

# Holds generic piece attributes to be inherited by specific piece classes
class Piece
  attr_reader :colour

  def initialize(colour)
    @colour = colour
  end

  def valid_standard_movement?(squares, board, captured)
    in_possible_destinations?(squares, captured) && unblocked_path?(squares, board)
  end

  private

  def unicode_symbol(white_symbol, black_symbol)
    @colour == 'white' ? white_symbol : black_symbol
  end

  def unblocked_path?(_squares, _board)
    true
  end
end
