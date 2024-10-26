# frozen_string_literal: true

# Interacts with the user
module UI
  private

  def player_input
    puts 'Input your move: '
    loop do
      move = gets.chomp
      return move.downcase if /^[rds]$/.match?(move.downcase)
      return move if /^[a-h][1-8][a-h][1-8][pnbrqkEcC]?[NBRQ]?$/.match?(move)

      puts "Invalid syntax. Input it in the form '<from square><to square>[<capture indicator>][<promoted to>]': "
    end
  end

  def accept_draw?
    puts "#{@current_player.name} is proposing a draw. Does #{other_player.name} accept this proposal? (y/n)"
    loop do
      choice = gets.chomp.downcase
      return choice == 'y' if /^[yn]$/.match?(choice)

      puts "Invalid input. Enter 'y' to accept the draw or 'n' to reject it."
    end
  end

  def overwrite_data?
    puts "A game between these two players has already been saved.\nWould you like to overwrite this save data? (y/n)"

    loop do
      choice = gets.chomp
      return choice == 'y' if choice.match(/^[yn]$/)

      puts "Invalid input. Enter 'y' to overwrite the existing save data or 'n' to cancel the saving operation."
    end
  end
end
