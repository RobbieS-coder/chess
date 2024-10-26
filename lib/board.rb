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

  def initialize(move_history)
    @move_history = move_history
    @white_king = King.new('white')
    @black_king = King.new('black')
    @game_board = assign_board
  end

  def valid_move?(move, colour)
    parsed_move = parse_move(move)
    from, to, captured, promoted = parsed_move.values_at(:from, :to, :captured, :promoted)
    from_piece = @game_board[from.first][from.last]
    return false unless preliminary_checks([from, to], colour, captured)
    return false unless promotion_checks(from, to, promoted)
    return false unless from_piece.in_possible_destinations?([from, to], abbrev_board, captured)
    return unless legal_move?(move, colour, captured)

    true
  end

  def update_board(move, board = @game_board)
    parsed_move = parse_move(move)
    from, to, captured, promoted = parsed_move.values_at(:from, :to, :captured, :promoted)
    move_piece(from, to, board)
    en_passant_capture(from.first, to.last, board) if captured == 'E'
    castle(from.first, captured, board) if captured&.match?(/^[cC]$/)
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
     king(colour), Bishop.new(colour), Knight.new(colour), Rook.new(colour)]
  end

  def pawn_row(colour)
    Array.new(8) { Pawn.new(colour) }
  end

  def abbrev_board(board = @game_board)
    board.map { |row| row.map { |square| square&.abbrev } }
  end

  def temp_board(move = nil)
    board = @game_board.map(&:dup)
    update_board(move, board) if move
    board
  end

  def king(colour)
    colour == 'white' ? @white_king : @black_king
  end

  def preliminary_checks(squares, colour, captured)
    from, to = squares
    from_piece = @game_board[from.first][from.last]
    to_piece = @game_board[to.first][to.last]
    en_passant_capturing = from_piece.instance_of?(Pawn) && captured == 'E'
    castling = from_piece.instance_of?(King) && captured&.match?(/^[cC]$/)
    return false unless valid_from_piece?(from_piece, colour)
    return false unless en_passant_capturing || castling || valid_to_piece?(to_piece, captured, colour)

    true
  end

  def valid_from_piece?(from_piece, colour)
    from_piece && from_piece.colour == colour
  end

  def valid_to_piece?(to_piece, captured, colour)
    return to_piece && to_piece.abbrev == captured && to_piece.colour != colour if captured

    to_piece.nil?
  end

  def promotion_checks(from, to, promoted)
    from_piece = @game_board[from.first][from.last]
    to_rank = to.first
    if promoted
      return false unless from_piece.instance_of?(Pawn) && [0, 7].include?(to_rank)
    elsif from_piece.instance_of?(Pawn) && [0, 7].include?(to_rank)
      return false
    end

    true
  end

  def move_piece(from, to, board)
    from_rank, from_file = from
    to_rank, to_file = to
    board[to_rank][to_file] = board[from_rank][from_file]
    board[from_rank][from_file] = nil
  end

  def en_passant_capture(rank, file, board)
    board[rank][file] = nil
  end

  def castle(rank, castling_type, board)
    board[rank][castling_type == 'c' ? 5 : 3] = board[rank][castling_type == 'c' ? 7 : 0]
    board[rank][castling_type == 'c' ? 7 : 0] = nil
  end

  def promote_pawn(to, promoted, board)
    to_rank, to_file = to
    piece_types = { N: Knight, B: Bishop, R: Rook, Q: Queen }
    colour = board[to_rank][to_file].colour
    new_piece = piece_types[promoted.to_sym].new(colour)
    board[to_rank][to_file] = new_piece
  end
end
