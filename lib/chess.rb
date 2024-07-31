# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'displayable'
require_relative 'move_history'

# Contains the loop to play chess and interfaces with all main classes
class Chess
  include Displayable

  def initialize(white = Player.new('white'), black = Player.new('black', white.name), move_history = MoveHistory.new)
    @board = Board.new
    @white = white
    @black = black
    @move_history = move_history
    @ui = UI.new
    @current_player = @white
  end

  def play
    loop do
      display_turn
      display
      move = @ui.player_input
      loop do
        break if @board.valid_move?(move, @current_player.colour)

        puts 'Invalid move'
        move = @ui.player_input
      end
      @board.update_board(move)
    end
  end
end
