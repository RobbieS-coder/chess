# frozen_string_literal: true

# Interacts with the user
class UI
  def player_input
    puts 'Input your move: '
    loop do
      move = gets.chomp
      return 'd' if move.downcase == 'd'
      return move if /^[a-h][1-8][a-h][1-8][pnbrqkEcC]?[NBRQ]?$/.match?(move)

      puts "Invalid syntax. Input it in the form '<from square><to square>[<capture indicator>][<promoted to>]': "
    end
  end
end
