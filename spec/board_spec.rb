# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#valid_move?' do
    context 'when moving pawn into occupied square' do
      xit 'returns false' do
      end
    end

    context 'when moving knight into occupied square' do
      xit 'returns false' do
      end
    end

    context 'when moving bishop into occupied square' do
      xit 'returns false' do
      end
    end

    context 'when moving rook into occupied square' do
      xit 'returns false' do
      end
    end

    context 'when moving queen into occupied square' do
      xit 'returns false' do
      end
    end

    context 'when moving king into occupied square' do
      xit 'returns false' do
      end
    end

    context 'when moving pawn two squares from starting rank without blocked path' do
      xit 'returns true' do
      end
    end

    context 'when moving pawn two squares from starting rank with blocked path' do
      xit 'returns false' do
      end
    end

    context 'when moving pawn one square from starting rank' do
      xit 'returns true' do
      end
    end

    context 'when moving pawn two squares from random rank' do
      xit 'returns false' do
      end
    end

    context 'when moving pawn one square from random rank' do
      xit 'returns true' do
      end
    end

    context 'when moving pawn diagonally to take a piece' do
      xit 'returns true' do
      end
    end

    context 'when moving pawn diagonally without taking a piece' do
      xit 'returns false' do
      end
    end

    context 'when moving knight in multiple valid directions' do
      xit 'returns true' do
      end
    end

    context 'when moving knight two squares' do
      xit 'returns false' do
      end
    end

    context 'when moving bishop diagonally without blocked path' do
      xit 'returns true' do
      end
    end

    context 'when moving bishop diagonally with blocked path' do
      xit 'returns false' do
      end
    end

    context 'when moving bishop vertically' do
      xit 'returns false' do
      end
    end

    context 'when moving bishop horizontally' do
      xit 'returns false' do
      end
    end

    context 'when moving rook vertically without blocked path' do
      xit 'returns true' do
      end
    end

    context 'when moving rook vertically with blocked path' do
      xit 'returns false' do
      end
    end

    context 'when moving rook horizontally without blocked path' do
      xit 'returns true' do
      end
    end

    context 'when moving rook horizontally with blocked path' do
      xit 'returns false' do
      end
    end

    context 'when moving rook diagonally' do
      xit 'returns false' do
      end
    end

    context 'when moving queen vertically without blocked path' do
      xit 'returns true' do
      end
    end

    context 'when moving queen vertically with blocked path' do
      xit 'returns true' do
      end
    end

    context 'when moving queen horizontally without blocked path' do
      xit 'returns true' do
      end
    end

    context 'when moving queen horizontally with blocked path' do
      xit 'returns true' do
      end
    end

    context 'when moving queen diagonally without blocked path' do
      xit 'returns true' do
      end
    end

    context 'when moving queen diagonally with blocked path' do
      xit 'returns true' do
      end
    end

    context 'when moving queen like a knight' do
      xit 'returns false' do
      end
    end

    context 'when moving king vertically one square' do
      xit 'returns true' do
      end
    end

    context 'when moving king horizontally one square' do
      xit 'returns true' do
      end
    end

    context 'when moving king diagonally one square' do
      xit 'returns true' do
      end
    end

    context 'when moving king two squares' do
      xit 'returns false' do
      end
    end
  end
end
