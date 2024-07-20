# frozen_string_literal: true

# Deals with outputs to the user
class Display
  def self.player_name(colour)
    puts "Input #{colour.capitalize}'s name: "
  end

  def self.invalid_player_name(colour)
    puts "Enter a name#{" that is different to the other player's" if colour == 'black'}: "
  end
end
