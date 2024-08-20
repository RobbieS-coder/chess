# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'displayable'

# Contains the loop to play chess and interfaces with all main classes
class Chess
  include Displayable

  def initialize(white = Player.new('white'), black = Player.new('black', white.name), board = Board.new)
    @board = board
    @white = white
    @black = black
    @ui = UI.new
    @current_player = @white
  end

  def play
    loop do
      display
      handle_move(valid_player_input)
      switch_player
    end
  end

  def valid_player_input
    loop do
      move = @ui.player_input

      case @board.valid_move?(move, @current_player.colour)
      when true then return move
      when false then puts 'Invalid move'
      when nil then puts 'Illegal move'
      end
    end
  end

  def handle_move(move)
    @board.update_board(move)
    @board.add_move(move)
  end

  def switch_player
    @current_player = @current_player == @white ? @black : @white
  end
end
