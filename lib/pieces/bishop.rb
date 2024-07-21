# frozen_string_literal: true

require_relative 'piece'

# Represents the bishop piece and its movement
class Bishop < Piece
  def symbol
    unicode_symbol("\u265d", "\u2657")
  end
end
