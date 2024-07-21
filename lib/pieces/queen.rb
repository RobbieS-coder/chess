# frozen_string_literal: true

require_relative 'piece'

# Represents the queen piece and its movement
class Queen < Piece
  def symbol
    unicode_symbol("\u265b", "\u2655")
  end
end
