# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/player'

describe Game do
  subject(:game) { described_class.new }

  describe '#play' do
    context 'when the game is over' do
      it 'ends the loop' do
        allow(game).to receive(:game_over?).and_return(true)
        allow(game).to receive(play)
        expect(game).to receive(:display_win_message)
        game.play
      end
    end
  end
end
