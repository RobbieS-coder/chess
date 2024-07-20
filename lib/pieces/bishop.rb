# frozen_string_literal: true

require_relative 'piece'

class Bishop < Piece
  def symbol
    unicode_symbol("\u265d", "\u2657")
  end
end
