# frozen_string_literal: true

# Deals with outputs to the user
class Display
  def self.player_name(colour)
    puts "Input #{colour.capitalize}'s name: "
  end

  def self.invalid_player_name(colour)
    puts "Enter a name#{" that is different to the other player's" if colour == 'black'}: "
  end

  def self.display_turn(colour)
    puts "#{colour.capitalize}'s turn"
  end

  def self.display(board, moves, colour)
    puts "#{file_indicators}\n"
    display_board(board)
    puts "\n"
    puts file_indicators
    display_recent_moves(moves, colour)
  end

  def self.file_indicators
    puts "     #{('a'..'h').to_a.join('    ')}"
  end

  def self.display_board(board)
    board.each_with_index do |row, row_index|
      puts format_empty_line(row_index)
      row.each_with_index { |piece, piece_index| row[piece_index] = format_square(piece, row_index, piece_index) }
      rank = 8 - row_index
      puts "#{rank}  #{row.join('')}  #{rank}"
      puts format_empty_line(row_index)
    end
  end

  def self.format_square(piece, row_index, piece_index)
    square_colour = (row_index + piece_index).even? ? "\e[48;5;243m" : "\e[48;5;16m"
    "#{square_colour}  #{piece}  \e[0m"
  end

  def self.format_empty_line(row_ind)
    "   #{(row_ind.even? ? "\e[48;5;243m     \e[48;5;16m     \e[0m" : "\e[48;5;16m     \e[48;5;243m     \e[0m") * 4}"
  end

  def self.display_recent_moves(moves, colour)
    current_colour = moves.length.even? ? colour : switch_colour(colour)
    puts (moves.map do |move|
      coloured_move = "#{current_colour == 'white' ? "\e[48;5;15m" : "\e[48;5;16m"}#{move}\e[0m"
      current_colour = switch_colour(current_colour)
      coloured_move
    end).join(', ')
  end

  def self.switch_colour(colour)
    colour == 'white' ? 'black' : 'white'
  end

  private_class_method :format_square, :format_empty_line
end
