# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'display'

# Contains the loop to play chess and interfaces with all main classes
class Chess
  def initialize(board = Board.new, white = Player.new('white'), black = Player.new('black', white.name))
    @board = board
    @white = white
    @black = black
    @current_player = @white
  end
end
