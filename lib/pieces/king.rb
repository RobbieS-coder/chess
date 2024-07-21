# frozen_string_literal: true

require_relative 'piece'

# Represents the king piece and its movement
class King < Piece
  def symbol
    unicode_symbol("\u265a", "\u2654")
  end
end
