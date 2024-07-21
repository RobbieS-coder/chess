# frozen_string_literal: true

require_relative 'display'

# Holds player information and gets user input
class Player
  attr_reader :name, :colour

  def initialize(colour, other_name = nil, name = assign_name(colour, other_name))
    @colour = colour
    @name = name
  end

  def player_input; end

  private

  def assign_name(colour, other_name)
    Display.player_name(colour)
    loop do
      name = gets.chomp
      return name unless name.empty? || name == other_name

      Display.invalid_player_name(colour)
    end
  end
end
