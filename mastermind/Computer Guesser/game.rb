# frozen_string_literal: true

require_relative 'display.rb'

# Contains logic for game
class Game
  include Display
  attr_reader :board, :guesser

  def initialize
    @code_peg_colors = %w[red orange yellow green blue purple]
    @board = Board.new
    @guesser = true
  end

  def play
    display_intro
    guesser_mastermind
    place_code_pegs
    take_turns
  end

  def guesser_mastermind
    player_guess = gets.chomp.downcase
    case player_guess
    when 'y'
      @guesser = true
    when 'n'
      @guesser = false
    else
      puts "Please enter 'Y' or 'N'."
      guesser_mastermind
    end
  end

  def place_code_pegs
    @board.code_row = choose_code_pegs
  end

  def choose_code_pegs
    chosen_code_pegs = []
    if guesser
      random_color_sample(chosen_code_pegs)
    else
      puts display_code_pick_prompt
      chosen_code_pegs = gets.chomp.split
    end
    chosen_code_pegs
  end

  def random_color_sample(array)
    4.times do
      array.push(@code_peg_colors.sample)
    end
  end

  def take_turns
    12.times do
      make_a_guess
      check_guess
      if @board.game_over?
        puts display_win_message
        break
      end
    end
    puts display_lose_message unless @board.game_over?
  end

  def make_a_guess
    puts display_guess_prompt
    if guesser
      guess = gets.chomp
      @board.guess_row = guess.split
    else
      guess = []
      random_color_sample(guess)
      @board.guess_row = guess
    end
  end

  def check_guess
    code_pegs = hash_pegs(@board.code_row)
    guess_pegs = hash_pegs(@board.guess_row)
    perfect_matches = select_perfect_match(@board.code_row, @board.guess_row)
    codepegs_sub_perf = subtract_perfect_matches(code_pegs, perfect_matches)
    guesspegs_sub_perf = subtract_perfect_matches(guess_pegs, perfect_matches)
    perfect_match_number = sum_pegs_from_hash(perfect_matches)
    imperfect_match_number = sum_imperfect_matches(codepegs_sub_perf, guesspegs_sub_perf)
    puts display_number_of_matches(perfect_match_number, imperfect_match_number)
  end

  def hash_pegs(pegs)
    pegs.reduce(Hash.new(0)) do |result, peg|
      result[peg] += 1
      result
    end
  end

  def select_perfect_match(code, guess)
    perfect = Hash.new(0)
    code.each_with_index do |peg, index|
      perfect[peg] += 1 if peg == guess[index]
    end
    perfect
  end

  def subtract_perfect_matches(pegs, perfect)
    pegs.merge(perfect) do |peg, oldval, newval|
      oldval - newval
    end
  end

  def sum_pegs_from_hash(hash)
    hash.values.reduce(0) do |sum, num|
      sum += num
      sum
    end
  end

  def sum_imperfect_matches(code, guess)
    ary = 0
    code.each do |peg, num|
      if guess[peg] && guess[peg] < num
        ary += guess[peg]
      elsif guess[peg] && guess[peg] >= num
        ary += num
      end
    end
    ary
  end
end
