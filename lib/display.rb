# frozen_string_literal: true

# Deals with outputs to the user
class Display
  def self.player_name(colour)
    puts "Input #{colour.capitalize}'s name: "
  end

  def self.invalid_player_name(colour)
    puts "Enter a name#{" that is different to the other player's" if colour == 'black'}: "
  end

  def self.display_board(board, moves)
    board.each_with_index do |row, row_index|
      puts format_empty_line(row_index)
      row.each_with_index { |piece, piece_index| row[piece_index] = format_square(piece, row_index, piece_index) }
      puts row.join('')
      puts format_empty_line(row_index)
    end
  end

  def self.format_square(piece, row_index, piece_index)
    square_colour = (row_index + piece_index).even? ? "\e[48;5;243m" : "\e[48;5;16m"
    "#{square_colour}  #{piece}  \e[0m"
  end

  def self.format_empty_line(row_ind)
    (0..7).to_a.map { |sq_ind| "#{(row_ind + sq_ind).even? ? "\e[48;5;243m" : "\e[48;5;16m"}     \e[0m" }.join('')
  end

  private_class_method :format_square, :format_empty_line
end
