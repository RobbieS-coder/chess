# frozen_string_literal: true

# Holds generic piece attributes to be inherited by specific piece classes
class Piece
  attr_reader :colour

  def initialize(colour)
    @colour = colour
  end

  def valid_standard_movement?(squares, board, captured)
    in_possible_destinations?(squares, captured) && unblocked_path?(squares, board)
  end

  private

  def unicode_symbol(white_symbol, black_symbol)
    @colour == 'white' ? white_symbol : black_symbol
  end

  def unblocked_path?(_squares, _board)
    true
  end

  def straight_line_in_possible_destinations?(squares, directions)
    from, to = squares
    rank, file = from
    destinations = directions.flat_map do |rank_change, file_change|
      (1..7).map { |i| [rank + i * rank_change, file + i * file_change] }
            .take_while { |new_rank, new_file| new_rank.between?(0, 7) && new_file.between?(0, 7) }
    end
    destinations.include?(to)
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
