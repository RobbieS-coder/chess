# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#valid_move?' do
    context 'when moving pawn into occupied square of other colour' do
      before do
        setup_moves = %w[e2e4 e7e5]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns false' do
        expect(board.valid_move?('e4e5', 'white')).to be(false)
      end
    end

    context 'when moving pawn into occupied square of same colour' do
      before do
        setup_moves = %w[e2e4 d7d5 e4d5p a7a6 d2d4 a6a5]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns false' do
        expect(board.valid_move?('d4d5', 'white')).to be(false)
      end
    end

    context 'when moving knight into occupied square of same colour' do
      it 'returns false' do
        expect(board.valid_move?('g1e2', 'white')).to be(false)
      end
    end

    context 'when moving bishop into occupied square of same colour' do
      it 'returns false' do
        expect(board.valid_move?('f1e2', 'white')).to be(false)
      end
    end

    context 'when moving rook into occupied square of same colour' do
      it 'returns false' do
        expect(board.valid_move?('h1h2', 'white')).to be(false)
      end
    end

    context 'when moving queen into occupied square of same colour' do
      it 'returns false' do
        expect(board.valid_move?('d1d2', 'white')).to be(false)
      end
    end

    context 'when moving king into occupied square of same colour' do
      it 'returns false' do
        expect(board.valid_move?('e1e2', 'white')).to be(false)
      end
    end

    context 'when moving pawn two squares from starting rank without blocked path' do
      it 'returns true' do
        expect(board.valid_move?('e2e4', 'white')).to be(true)
      end
    end

    context 'when moving pawn two squares from starting rank with blocked path' do
      before do
        setup_moves = %w[a2a3 e7e5 a3a4 e5e4 a4a5 e4e3]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns false' do
        expect(board.valid_move?('e2e4', 'white')).to be(false)
      end
    end

    context 'when moving pawn one square from starting rank' do
      it 'returns true' do
        expect(board.valid_move?('e2e3', 'white')).to be(true)
      end
    end

    context 'when moving pawn two squares from random rank' do
      before do
        setup_moves = %w[e2e4 a7a6]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns false' do
        expect(board.valid_move?('e4e6', 'white')).to be(false)
      end
    end

    context 'when moving pawn one square from random rank' do
      before do
        setup_moves = %w[e2e4 a7a6]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.valid_move?('e4e5', 'white')).to be(true)
      end
    end

    context 'when moving pawn diagonally to take a piece' do
      before do
        setup_moves = %w[e2e4 d7d5]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.valid_move?('e4d5p', 'white')).to be(true)
      end
    end

    context 'when moving pawn diagonally without taking a piece' do
      it 'returns false' do
        expect(board.valid_move?('e2d3', 'white')).to be(false)
      end
    end

    context 'when moving knight two up then one across' do
      it 'returns true' do
        expect(board.valid_move?('g1f3', 'white')).to be(true)
      end
    end

    context 'when moving knight one up then two across' do
      before do
        setup_moves = %w[g1f3 a7a6]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.valid_move?('f3d4', 'white')).to be(true)
      end
    end

    context 'when moving knight two down then one across' do
      before do
        setup_moves = %w[g1f3 a7a6]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.valid_move?('f3g1', 'white')).to be(true)
      end
    end

    context 'when moving knight one down then two across' do
      before do
        setup_moves = %w[g1f3 a7a6 f3d4 a6a5]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.valid_move?('d4f3', 'white')).to be(true)
      end
    end

    context 'when moving knight two squares' do
      it 'returns false' do
        expect(board.valid_move?('g1g3', 'white')).to be(false)
      end
    end

    context 'when moving knight to take piece' do
      before do
        setup_moves = %w[g1f3 e7e5]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.valid_move?('f3e5p', 'white')).to be(true)
      end
    end

    context 'when moving bishop diagonally without blocked path' do
      before do
        setup_moves = %w[e2e4 a7a6]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.valid_move?('f1c4', 'white')).to be(true)
      end
    end

    context 'when moving bishop diagonally with blocked path' do
      it 'returns false' do
        expect(board.valid_move?('f1c4', 'white')).to be(false)
      end
    end

    context 'when moving bishop vertically' do
      before do
        setup_moves = %w[f2f4 a7a6]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns false' do
        expect(board.valid_move?('f1f3', 'white')).to be(false)
      end
    end

    context 'when moving bishop horizontally' do
      before do
        setup_moves = %w[g1f3 a7a6]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns false' do
        expect(board.valid_move?('f1g1', 'white')).to be(false)
      end
    end

    context 'when moving bishop to take piece' do
      before do
        setup_moves = %w[e2e4 b7b5]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.valid_move?('f1b5p', 'white')).to be(true)
      end
    end

    context 'when moving rook vertically without blocked path' do
      before do
        setup_moves = %w[h2h4 a7a6]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.valid_move?('h1h3', 'white')).to be(true)
      end
    end

    context 'when moving rook vertically with blocked path' do
      it 'returns false' do
        expect(board.valid_move?('h1h3', 'white')).to be(false)
      end
    end

    context 'when moving rook horizontally without blocked path' do
      before do
        setup_moves = %w[g1f3 a7a6]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.valid_move?('h1g1', 'white')).to be(true)
      end
    end

    context 'when moving rook horizontally with blocked path' do
      before do
        setup_moves = %w[b1c3 a7a6]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns false' do
        expect(board.valid_move?('h1b1', 'white')).to be(false)
      end
    end

    context 'when moving rook diagonally' do
      before do
        setup_moves = %w[g2g4 a7a6]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns false' do
        expect(board.valid_move?('h1e4', 'white')).to be(false)
      end
    end

    context 'when moving rook to take piece' do
      before do
        setup_moves = %w[h2h4 g7g5 h4g5p h7h5]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.valid_move?('h1h5p', 'white')).to be(true)
      end
    end

    context 'when moving queen vertically without blocked path' do
      before do
        setup_moves = %w[d2d4 a7a6]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.valid_move?('d1d3', 'white')).to be(true)
      end
    end

    context 'when moving queen vertically with blocked path' do
      it 'returns false' do
        expect(board.valid_move?('d1d3', 'white')).to be(false)
      end
    end

    context 'when moving queen horizontally without blocked path' do
      before do
        setup_moves = %w[d2d4 a7a6 d1d3 a6a5]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.valid_move?('d3h3', 'white')).to be(true)
      end
    end

    context 'when moving queen horizontally with blocked path' do
      before do
        setup_moves = %w[b1c3 a7a6]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns false' do
        expect(board.valid_move?('d1b1', 'white')).to be(false)
      end
    end

    context 'when moving queen diagonally without blocked path' do
      before do
        setup_moves = %w[e2e4 a7a6]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.valid_move?('d1f3', 'white')).to be(true)
      end
    end

    context 'when moving queen diagonally with blocked path' do
      it 'returns false' do
        expect(board.valid_move?('d1f3', 'white')).to be(false)
      end
    end

    context 'when moving queen like a knight' do
      it 'returns false' do
        expect(board.valid_move?('d1e3', 'white')).to be(false)
      end
    end

    context 'when moving queen to take piece' do
      before do
        setup_moves = %w[d2d4 e7e5 d4e5p d7d5]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.valid_move?('d1d5p', 'white')).to be(true)
      end
    end

    context 'when moving king vertically one square' do
      before do
        setup_moves = %w[e2e4 a7a6]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.valid_move?('e1e2', 'white')).to be(true)
      end
    end

    context 'when moving king horizontally one square' do
      before do
        setup_moves = %w[e2e4 a7a6 e1e2 a6a5 e2e3 a5a4]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.valid_move?('e3d3', 'white')).to be(true)
      end
    end

    context 'when moving king diagonally one square' do
      before do
        setup_moves = %w[e2e4 a7a6 e1e2 a6a5]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.valid_move?('e2d3', 'white')).to be(true)
      end
    end

    context 'when moving king two squares' do
      before do
        setup_moves = %w[e2e4 a7a6]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns false' do
        expect(board.valid_move?('e1e3', 'white')).to be(false)
      end
    end

    context 'when moving king to take piece' do
      before do
        setup_moves = %w[d2d4 e7e5 e1d2 e5e4 a2a3 e4e3]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.valid_move?('d2e3p', 'white')).to be(true)
      end
    end
  end

  describe '#in_check?' do
    context 'when white king is not in check' do
      it 'returns false' do
        expect(board.in_check?('white')).to be(false)
      end
    end

    context 'when white king can be moved into by a pawn' do
      before do
        setup_moves = %w[e2e4 d7d5 e1e2 d5e4p a2a3 e4e3]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns false' do
        expect(board.in_check?('white')).to be(false)
      end
    end

    context 'when white king is in check by a pawn' do
      before do
        setup_moves = %w[e2e4 d7d5 e1e2 a7a6 e2d3 d5e4p]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.in_check?('white')).to be(true)
      end
    end

    context 'when white king is in check by a knight' do
      before do
        setup_moves = %w[f2f3 g8f6 e1f2 f6e4]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.in_check?('white')).to be(true)
      end
    end

    context 'when white king is in check by a bishop' do
      before do
        setup_moves = %w[d2d4 e7e5 a2a3 f8b4]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.in_check?('white')).to be(true)
      end
    end

    context 'when white king is in check by a rook' do
      before do
        setup_moves = %w[e2e4 h7h5 e4e5 h8h6 e5e6 h6e6p]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.in_check?('white')).to be(true)
      end
    end

    context 'when white king is in check by a queen' do
      before do
        setup_moves = %w[d2d4 c7c5 a2a3 d8a5]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.in_check?('white')).to be(true)
      end
    end

    context 'when taking piece that is targeting white king' do
      before do
        setup_moves = %w[e2e4 d7d5 e1e2 d5d4 a2a3 d4d3 c2d3p]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.in_check?('white')).to be(true)
      end
    end

    context 'when black king is not in check' do
      it 'returns false' do
        expect(board.in_check?('black')).to be(false)
      end
    end

    context 'when black king can be moved into by a pawn' do
      before do
        setup_moves = %w[d2d4 e7e5 d4e5p e8e7 e5e6]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns false' do
        expect(board.in_check?('black')).to be(false)
      end
    end

    context 'when black king is in check by a pawn' do
      before do
        setup_moves = %w[e2e4 d7d5 e4d5p e7e6 a2a3 e8e7 d5d6]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.in_check?('black')).to be(true)
      end
    end

    context 'when black king is in check by a knight' do
      before do
        setup_moves = %w[g1f3 f7f6 a2a3 e8f7 f3g5]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.in_check?('black')).to be(true)
      end
    end

    context 'when black king is in check by a bishop' do
      before do
        setup_moves = %w[e2e4 d7d5 f1b5]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.in_check?('black')).to be(true)
      end
    end

    context 'when black king is in check by a rook' do
      before do
        setup_moves = %w[h2h4 e7e5 h1h3 a7a6 h3e3 a6a5 e3e5p]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.in_check?('black')).to be(true)
      end
    end

    context 'when black king is in check by a queen' do
      before do
        setup_moves = %w[e2e4 f7f5 d1h5]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.in_check?('black')).to be(true)
      end
    end

    context 'when taking piece that is targeting black king' do
      before do
        setup_moves = %w[e2e4 d7d5 a2a3 a7a6 f1b5 a6b5p]
        setup_moves.each { |move| board.update_board(move) }
      end

      it 'returns true' do
        expect(board.in_check?('black')).to be(true)
      end
    end
  end
end
