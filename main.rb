# frozen_string_literal: true

require_relative 'lib/serialiser'
require_relative 'lib/chess'
require_relative 'lib/player'

def choose_game_type
  puts 'Do you want to load a saved game or start a new one? (l/n)'

  loop do
    game_type = gets.chomp.downcase
    return game_type if game_type.match(/^[ln]$/)

    puts "Invalid input. Enter 'l' to load a game or 'n' to start a new one"
  end
end

game_type = choose_game_type

data = Serialiser.load_data if game_type == 'l'

white, black, history = data if game_type == 'l'

(game_type == 'l' && data ? Chess.new(white, black, history) : Chess.new).play
