# frozen_string_literal: true

require_relative 'piece'

# Represents the pawn piece and its movement
class Pawn < Piece
  def symbol
    unicode_symbol("\u265f", "\u2659")
  end
end
