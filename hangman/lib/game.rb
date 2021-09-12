# frozen_string_literal: true

require 'json'
require_relative 'display.rb'
require_relative 'hangman_visuals.rb'

# Contains logic for game

class Game
  include Display
  include HangmanVisuals
  attr_accessor :word, :wrong_guesses, :cguess_pool, :wguess_pool, :word_char_spots

  def initialize
    @wrong_guesses = 0
    @cguess_pool = []
    @wguess_pool = []
    @word = generate_word
    @word_char_spots = make_dashes(word)
  end

  def select_game_type
    type = gets.chomp
    case type
    when 'new'
      new_game
    when 'old'
      old_game
    else
      puts 'error: enter \'new\' or \'old\'.'
      select_game_type
    end
  end

  def new_game
    play
  end

  def old_game
    from_json(File.open('saved_game.json', 'r').read)
    play
  end
  
  def play
    until wrong_guesses == 6 || game_won?
      take_turn
    end
    if game_won?
      puts display_win_message(word)
    else
      puts current_hang
      puts display_loss_message(word)
    end
  end

  def generate_word
    file = File.open('5desk.txt', 'r')
    word = file.readlines.sample.chomp
    file.rewind
    until word.length >= 5 && word.length <= 12
      word = file.readlines.sample.chomp
      file.rewind
    end
    word
  end

  def make_dashes(word)
    dashes = ''
    word.length.times do
      dashes += '_ '
    end
    dashes.rstrip
  end

  def take_turn
    puts display_correct_guesses(place_correct_guesses(cguess_pool), word_char_spots)
    puts current_hang
    puts display_wrong_guesses(wguess_pool.join(', '))
    make_guess(guess_input)
    place_correct_guesses(cguess_pool)
  end

  def save_game
    File.open('saved_game.json', 'w') do |f|
      f.write(to_json)
    end
  end

  def make_guess(guess)
    if word.include?(guess)
      cguess_pool.push(guess)
    else
      wguess_pool.push(guess)
      self.wrong_guesses += 1
    end
  end

  def place_correct_guesses(guessed_letters)
    fill_out = ''
    word.each_char do |c|
      if guessed_letters.include?(c)
        fill_out += "#{c} "
      else
        fill_out += '  '
      end
    end
    fill_out.rstrip
  end

  def guess_input
    guess = gets.chomp.downcase
    if guess == 'save'
      save_game
      puts 'See you later!'
      exit
    elsif guess.length > 1
      puts 'Please enter only 1 letter.'
      guess_input
    elsif cguess_pool.include?(guess) || wguess_pool.include?(guess)
      puts 'You\'ve already guessed this letter. Please guess another.'
      guess_input
    elsif guess.match?(/[a-z]/)
      guess
    else
      puts 'Please enter a letter.'
      guess_input
    end
  end

  def current_hang
    case wrong_guesses
    when 0
      hang_zero
    when 1
      hang_one
    when 2
      hang_two
    when 3
      hang_three
    when 4
      hang_four
    when 5
      hang_five
    when 6
      hang_full
    else
      'error'
    end
  end

  def game_won?
    word == place_correct_guesses(cguess_pool).gsub(/\s+/, '')
  end

  def to_json
    JSON.dump ({
      word: @word,
      word_char_spots: @word_char_spots,
      cguess_pool: @cguess_pool,
      wguess_pool: @wguess_pool,
      wrong_guesses: @wrong_guesses
    })
  end
  
  def from_json(string)
    data = JSON.load(string)
    self.word = data['word']
    self.word_char_spots = data['word_char_spots']
    self.cguess_pool = data['cguess_pool']
    self.wguess_pool = data['wguess_pool']
    self.wrong_guesses = data['wrong_guesses']
  end
end
