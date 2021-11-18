# frozen_string_literal: true

require_relative '../lib/tic_tac_toe'

describe TicTacToeBoard do
  subject(:game) { described_class.new }
  describe '#make_move' do
    context 'when input is valid integer' do
      before do
        valid_input = '5'
        allow(game).to receive(:gets).and_return(valid_input)
        allow(game).to receive(:display_valid_number)
      end

      it 'changes the space value to the input' do
        game.make_move
        expect(game.row_b[1]).to eq('X')
      end

      it 'adds 1 to the turn counter' do
        game.make_move
        expect(game.turn_counter).to eq(1)
      end
    end

    context 'when input is not valid integer' do
      before do
        invalid_input = 'w'
        allow(game).to receive(:gets).and_return(invalid_input)
        allow(game).to receive(:display_valid_number)
      end

      it 'runs display_valid_number' do
        expect(game).to receive(:display_valid_number)
        game.make_move
      end
    end
  end

  describe '#display_valid_number' do
    context 'when invalid input received' do
      before do
        allow(game).to receive(:make_move)
      end

      it 'subtracts 1 from turn_counter' do
        game.display_valid_number
        expect(game.turn_counter).to eq(-1)
      end
    end
  end

  describe '#check_winner' do
    context 'when three symbols in a row are hit' do
      it 'returns true' do
        game.row_a[0] = 'X'
        game.row_a[1] = 'X'
        game.row_a[2] = 'X'
        expect(game.check_winner).to be(true)
      end
    end

    context 'when three symbols in a row are not hit' do
      it 'returns false' do
        game.row_a[0] = 'X'
        game.row_a[1] = 'X'
        expect(game.check_winner).to be(false)
      end
    end
  end

  describe '#shift_input' do
    context 'when input is X' do
      it 'switches input to O' do
        game.turn_counter = 1
        game.shift_input
        expect(game.input).to eq('O')
      end
    end
    
    context 'when input is O' do
      it 'switches input to X' do
        game.turn_counter = 2
        game.shift_input
        expect(game.input).to eq('X')
      end
    end
  end

  describe '#check_tie' do
    
  end

  describe '#play_again' do
    
  end

  describe '#replay' do
    
  end

  describe '#play' do
    
  end
end