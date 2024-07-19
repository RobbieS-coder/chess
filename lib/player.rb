# frozen_string_literal: true

class Player
  attr_reader :name, :colour

  def initialize(colour, other_name = nil, name = assign_name(colour, other_name))
    @colour = colour
    @name = name
  end

  def player_input; end

  private

  def assign_name(colour, other_name = nil)
    puts "Input #{colour.capitalize}'s name: "
    loop do
      name = gets.chomp
      return name unless name.empty? || name == other_name

      puts "Enter a name#{" that is different to the other player's" if colour == 'black'}: "
    end
  end

  def valid_move?; end
end
