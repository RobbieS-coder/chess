# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'display'
require_relative 'move_history'

# Contains the loop to play chess and interfaces with all main classes
class Chess
  def initialize(board = Board.new, white = Player.new('white'), black = Player.new('black', white.name),
                 move_history = MoveHistory.new)
    @board = board
    @white = white
    @black = black
    @move_history = move_history
    @current_player = @white
  end

  def play
    Display.display_board(@board.symbol_board, @move_history.recent_moves)
  end
end
