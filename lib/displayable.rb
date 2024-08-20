# frozen_string_literal: true

# Deals with outputs to the user
module Displayable
  private

  def display
    colour = @current_player.colour
    puts "#{colour == 'white' ? "\e[48;5;15m\e[30m" : "\e[48;5;16m\e[37m"}#{colour.capitalize}'s\e[0m turn"
    puts "#{file_indicators}\n"
    display_board
    puts "\n"
    puts file_indicators
    display_recent_moves
    puts 'Check!' if @board.in_check?(@current_player.colour)
  end

  def file_indicators
    puts "     #{('a'..'h').to_a.join('    ')}"
  end

  def display_board
    @board.symbol_board.each_with_index do |row, row_index|
      puts format_empty_line(row_index)
      row.each_with_index { |piece, piece_index| row[piece_index] = format_square(piece, row_index, piece_index) }
      rank = 8 - row_index
      puts "#{rank}  #{row.join('')}  #{rank}"
      puts format_empty_line(row_index)
    end
  end

  def format_square(piece, row_index, piece_index)
    square_colour = (row_index + piece_index).even? ? "\e[48;5;243m" : "\e[48;5;16m"
    "#{square_colour}  #{piece}  \e[0m"
  end

  def format_empty_line(row_ind)
    "   #{(row_ind.even? ? "\e[48;5;243m     \e[48;5;16m     \e[0m" : "\e[48;5;16m     \e[48;5;243m     \e[0m") * 4}"
  end

  def display_recent_moves
    moves = @board.recent_moves
    colour = @current_player.colour
    current_colour = moves.length.even? ? colour : switch_colour(colour)
    moves_str = (moves.map do |move|
      coloured_move = "#{current_colour == 'white' ? "\e[48;5;15m\e[30m" : "\e[48;5;16m\e[37m"}#{move}\e[0m"
      current_colour = switch_colour(current_colour)
      coloured_move
    end).join(' ')
    puts "  #{moves_str}"
  end

  def switch_colour(colour)
    colour == 'white' ? 'black' : 'white'
  end
end
