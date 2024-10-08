# frozen_string_literal: true

# Holds generic piece attributes to be inherited by specific piece classes
class Piece
  attr_reader :colour

  def initialize(colour)
    @colour = colour
  end

  def in_possible_destinations?(squares, board, captured)
    from, to = squares
    possible_destinations(from, board, captured).include?(to)
  end

  private

  def unicode_symbol(white_symbol, black_symbol)
    @colour == 'white' ? white_symbol : black_symbol
  end

  def straight_line_possible_destinations(from, directions)
    rank, file = from
    destinations = directions.flat_map do |rank_change, file_change|
      (1..7).map { |i| [rank + i * rank_change, file + i * file_change] }
    end
    destinations.filter { |new_rank, new_file| new_rank.between?(0, 7) && new_file.between?(0, 7) }
  end

  def diagonal_unblocked_path?(from, to, board)
    from_rank, from_file = from
    to_rank, to_file = to
    rank_stp = to_rank > from_rank ? 1 : -1
    file_stp = to_file > from_file ? 1 : -1
    (1...((to_rank - from_rank).abs)).all? { |stp| board[from_rank + stp * rank_stp][from_file + stp * file_stp].nil? }
  end

  def vert_hor_unblocked_path?(from, to, board)
    from_rank, from_file = from
    to_rank, to_file = to

    if from_rank == to_rank
      (([from_file, to_file].min + 1)...[from_file, to_file].max).all? { |file| board[from_rank][file].nil? }
    else
      (([from_rank, to_rank].min + 1)...[from_rank, to_rank].max).all? { |rank| board[rank][from_file].nil? }
    end
  end
end
