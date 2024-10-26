# frozen_string_literal: true

require_relative 'player'

# Saves and loads the game
class Serialiser
  def self.save_game(white_name, black_name, history)
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')

    file_path = "saved_games/#{white_name}|#{black_name}.marshal"

    return if File.exist?(file_path) && !overwrite_data?

    File.open(file_path, 'w') { |file| file.write(history) }
    puts 'Game Saved!'
  end

  def self.load_data
    unless Dir.exist?('saved_games')
      puts "No save data found\nStarting new game"
      return
    end

    file_name = select_file(Dir.children('saved_games'))

    white, black = file_name.split('|')
    history = File.open("saved_games/#{file_name}.marshal", 'r') { |file| Marshal.load(File.read(file)) }

    [Player.new('white', nil, white), Player.new('black', nil, black), history]
  end

  def self.overwrite_data?
    puts "A game between these two players has already been saved.\nWould you like to overwrite this save data? (y/n)"

    loop do
      choice = gets.chomp
      return choice == 'y' if choice.match(/^[yn]$/)

      puts "Invalid input. Enter 'y' to overwrite the existing save data or 'n' to cancel the saving operation."
    end
  end

  def self.select_file(saved_games)
    saved_games.map! { |game| game.split('.').first }
    saved_games.each_with_index { |file, i| puts "#{i + 1}: #{file.split('|').join(' vs ')}" }
    puts 'Enter the number corresponding to the game you want to load.'

    loop do
      file_num = gets.chomp.to_i
      return saved_games[file_num - 1] if file_num.positive? && file_num <= saved_games.length

      puts "Invalid input. Enter a number between 1 and #{saved_games.length}."
    end
  end
end
