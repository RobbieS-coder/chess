# frozen_string_literal: true

require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'notation_parser'
require_relative 'game_rules'

# Holds game board and interfaces with pieces
class Board
  include NotationParser
  include GameRules

  def initialize
    @white_king = King.new('white')
    @black_king = King.new('black')
    @game_board = assign_board
  end

  def valid_move?(move, colour)
    parsed_move = parse_move(move.dup)
    from, to, captured, promoted = parsed_move.values_at(:from, :to, :captured, :promoted)
    from_piece = @game_board[from.first][from.last]
    return false unless preliminary_checks([from, to], colour, captured)
    return false unless promotion_checks(from, to, promoted)
    return false unless from_piece.in_possible_destinations?([from, to], abbrev_board, captured)
    return unless legal_move?(temp_board(move), colour, captured)

    true
  end

  def update_board(move, board = @game_board)
    parsed_move = parse_move(move.dup)
    from, to, promoted = parsed_move.values_at(:from, :to, :promoted)
    from_rank, from_file = from
    to_rank, to_file = to
    board[to_rank][to_file] = board[from_rank][from_file]
    board[from_rank][from_file] = nil
    promote_pawn(to, promoted, board) if promoted
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
     colour == 'white' ? @white_king : @black_king, Bishop.new(colour), Knight.new(colour), Rook.new(colour)]
  end

  def pawn_row(colour)
    Array.new(8) { Pawn.new(colour) }
  end

  def abbrev_board
    @game_board.map { |row| row.map { |square| square&.abbrev } }
  end

  def temp_board(move)
    board = @game_board.map(&:dup)
    update_board(move, board)
    board
  end

  def preliminary_checks(squares, colour, captured)
    from, to = squares
    from_piece = @game_board[from.first][from.last]
    to_piece = @game_board[to.first][to.last]
    return false if from_piece.nil? || from_piece.colour != colour
    return false if to_piece && (to_piece.abbrev != captured || to_piece.colour == colour)

    true
  end

  def promotion_checks(from, to, promoted)
    to_rank = to.first
    if promoted
      from_piece = @game_board[from.first][from.last]
      return false unless from_piece.instance_of?(Pawn) && [0, 7].include?(to_rank)
    elsif [0, 7].include?(to_rank)
      return false
    end

    true
  end

  def promote_pawn(to, promoted, board)
    to_rank, to_file = to
    piece_types = { N: Knight, B: Bishop, R: Rook, Q: Queen }
    colour = board[to_rank][to_file].colour
    new_piece = piece_types[promoted.to_sym].new(colour)
    board[to_rank][to_file] = new_piece
  end
end
