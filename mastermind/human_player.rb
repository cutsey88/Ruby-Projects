# frozen_string_literal: true

# Contains logic for the human player
class HumanPlayer
  attr_reader :code_pegs

  def initialize
    @code_pegs = %w[red orange yellow green blue purple]
  end
end
