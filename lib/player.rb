# frozen_string_literal: true

require_relative 'ui'

# Holds player information and gets user input
class Player
  attr_reader :name, :colour

  def initialize(colour, other_name = nil, name = assign_name(colour, other_name))
    @colour = colour
    @name = name
  end

  private

  def assign_name(colour, other_name)
    puts "Input #{colour.capitalize}'s name: "
    loop do
      name = gets.chomp
      return name unless name.empty? || name == other_name || !name.match?(/^[a-zA-Z]+$/)

      puts "Enter a name#{" that is different to the other player's and" if colour == 'black'} has only letters: "
    end
  end
end
