# frozen_string_literal: true

require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'

# Holds game board and interfaces with pieces
class Board
  def initialize
    @game_board = assign_board
  end

  def valid_move?(move); end

  def symbol_board
    @game_board.map { |row| row.map { |square| square.nil? ? ' ' : square.symbol } }
  end

  private

  def assign_board
    b = 'black'
    w = 'white'
    [back_row(b), pawn_row(b), Array.new(8), Array.new(8), Array.new(8), Array.new(8), pawn_row(w), back_row(w)]
  end

  def back_row(colour)
    [Rook.new(colour), Knight.new(colour), Bishop.new(colour), Queen.new(colour),
     King.new(colour), Bishop.new(colour), Knight.new(colour), Rook.new(colour)]
  end

  def pawn_row(colour)
    Array.new(8) { Pawn.new(colour) }
  end
end
