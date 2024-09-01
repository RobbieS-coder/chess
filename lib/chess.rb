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
      break if @board.game_over?(@current_player.colour)

      handle_move(valid_player_input)
      switch_player
    end
    announce_winner
  end

  private

  def valid_player_input
    loop do
      move = @ui.player_input

      case @board.valid_move?(move, @current_player.colour)
      when true then return move
      when false then puts 'Invalid move pattern'
      when nil then puts 'Illegal move'
      end
    end
  end

  def handle_move(move)
    @board.update_board(move)
    @board.add_move(move)
  end

  def switch_player
    @current_player = other_player
  end

  def other_player
    @current_player == @white ? @black : @white
  end
end
