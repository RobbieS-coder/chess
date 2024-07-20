# frozen_string_literal: true

require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'

# Holds game board and interfaces with pieces
class Board
  def initialize(game_board = assign_board)
    @game_board = game_board
  end

  def valid_move?; end

  def symbol_board
    @game_board.map { |row| row.map { |square| square.nil? ? ' ' : square.symbol } }
  end

  private

  def assign_board
    b = 'black'
    w = 'white'
    [[Rook.new(b), Knight.new(b), Bishop.new(b), Queen.new(b), King.new(b), Bishop.new(b), Knight.new(b), Rook.new(b)],
     Array.new(8) { Pawn.new(b) },
     Array.new(8),
     Array.new(8),
     Array.new(8),
     Array.new(8),
     Array.new(8) { Pawn.new(w) },
     [Rook.new(w), Knight.new(w), Bishop.new(w), Queen.new(w), King.new(w), Bishop.new(w), Knight.new(w), Rook.new(w)]]
  end
end
