# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/player'

describe Game do
  subject(:game) { described_class.new }

  describe '#initialize' do
    it 'creates a board' do
      expect(Board).to receive(:new)
      game
    end
  end

  describe '#play' do

    context 'before a turn is taken' do
      
    end

    context 'when the game is over' do
      it 'ends the loop' do
        allow(game).to receive(:game_over?).and_return(true)
        expect(game).to receive(:after_win)
        game.play
      end

      #Move test under after win method
      it 'shows the board' do
        answer = 'y'
        allow(game).to receive(:game_over?).and_return(true)
        allow(game).to receive(:play_again).once
        allow(game).to receive(:gets).and_return(answer).once

        expect(game.board).to receive(:show_board).once
        game.play
      end
    end
  end

  describe '#after_win' do
    it 'shows the board' do
      answer = 'n'
      expect(game.board).to receive(:show_board).once
      allow(game).to receive(:play_again).once
      allow(game).to receive(:gets).and_return(answer).once
      game.after_win
    end
  end
end
