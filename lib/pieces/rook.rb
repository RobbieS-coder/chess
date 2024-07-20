# frozen_string_literal: true

require_relative 'piece'

class Rook < Piece
  def symbol
    unicode_symbol("\u265c", "\u2656")
  end
end
