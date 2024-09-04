# frozen_string_literal: true

# Interacts with the user
module UI
  def player_input
    puts 'Input your move: '
    loop do
      move = gets.chomp
      return move.downcase if /[rd]/.match?(move.downcase)
      return move if /^[a-h][1-8][a-h][1-8][pnbrqkEcC]?[NBRQ]?$/.match?(move)

      puts "Invalid syntax. Input it in the form '<from square><to square>[<capture indicator>][<promoted to>]': "
    end
  end

  def accept_draw?
    puts "#{@current_player.name} is proposing a draw. Does #{other_player.name} accept this proposal? (y/n)"
    loop do
      choice = gets.chomp.downcase
      return choice == 'y' if /[yn]/.match?(choice)

      puts "Invalid input. Enter 'y' to accept the draw or 'n' to reject it."
    end
  end
end
