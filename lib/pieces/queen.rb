# frozen_string_literal: true

require_relative 'piece'

class Queen < Piece
  def symbol
    unicode_symbol("\u265b", "\u2655")
  end
end
