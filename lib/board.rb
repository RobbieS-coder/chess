# frozen_string_literal: true

require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'notation_parser'

# Holds game board and interfaces with pieces
class Board
  include NotationParser

  def initialize
    @game_board = assign_board
  end

  def valid_move?(move, colour)
    parsed_move = parse_move(move.dup)
    from, to, captured = parsed_move.values_at(:from, :to, :captured)
    from_piece = @game_board[from.first][from.last]
    to_piece = @game_board[to.first][to.last]
    return false if from_piece.nil? || from_piece.colour != colour
    return false if to_piece && (to_piece.abbrev != captured || to_piece.colour == colour)
    return false unless from_piece.valid_standard_movement?([from, to], abbrev_board, captured)

    true
  end

  def update_board(move)
    parsed_move = parse_move(move.dup)
    from, to = parsed_move.values_at(:from, :to)
    from_rank, from_file = from
    to_rank, to_file = to
    @game_board[to_rank][to_file] = @game_board[from_rank][from_file]
    @game_board[from_rank][from_file] = nil
  end

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

  def abbrev_board
    @game_board.map { |row| row.map { |square| square&.abbrev } }
  end
end
