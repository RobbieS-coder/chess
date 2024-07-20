# frozen_string_literal: true

require_relative 'piece'

class Knight < Piece
  def symbol
    unicode_symbol("\u265e", "\u2658")
  end
end
