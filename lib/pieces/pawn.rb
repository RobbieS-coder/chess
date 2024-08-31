# frozen_string_literal: true

require_relative 'piece'

# Represents the pawn piece and its movement
class Pawn < Piece
  attr_reader :start_rank

  def initialize(colour)
    super(colour)
    @start_rank = @colour == 'white' ? 6 : 1
    @direction = @colour == 'white' ? -1 : 1
  end

  def symbol
    unicode_symbol("\u265f", "\u2659")
  end

  def abbrev
    'p'
  end

  def possible_destinations(from, board, captured)
    rank, file = from
    destinations = []
    destinations += [[rank + @direction, file + 1], [rank + @direction, file - 1]] if captured
    destinations << [rank + @direction, file] unless captured
    destinations << [rank + 2 * @direction, file] if rank == @start_rank && !captured
    destinations.filter! { |new_rank, new_file| new_rank.between?(0, 7) && new_file.between?(0, 7) }
    destinations.filter { |destination| unblocked_path?(from, destination, board) }
  end

  private

  def unblocked_path?(from, to, board)
    from_rank, from_file = from
    to_rank = to.first
    travelled_squares = []
    travelled_squares << board[from_rank + @direction][from_file] if (to_rank - from_rank).abs == 2
    travelled_squares.all?(&:nil?)
  end
end
