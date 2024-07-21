# frozen_string_literal: true

# Keeps track of the moves made
class MoveHistory
  def initialize(history = [])
    @history = history
  end

  def add_move; end

  def recent_moves
    return @history[-4, 4] if @history.length >= 4

    @history
  end
end
