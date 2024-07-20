# frozen_string_literal: true

# Holds generic piece attributes to be inherited by specific piece classes
class Piece
  def initialize(colour)
    @colour = colour
  end

  private

  def unicode_symbol(white_symbol, black_symbol)
    @colour == 'white' ? white_symbol : black_symbol
  end
end
