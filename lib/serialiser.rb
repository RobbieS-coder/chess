# frozen_string_literal: true

# Saves and loads the game
module Serialiser
  def save_game(white_name, black_name)
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')

    file_path = "saved_games/#{white_name}|#{black_name}.marshal"

    return if File.exist?(file_path) && !overwrite_data?

    File.open(file_path, 'w') { |file| file.write(@move_history.serialised_history) }
    puts 'Game Saved!'
  end

  private

  def load_game
  end
end
