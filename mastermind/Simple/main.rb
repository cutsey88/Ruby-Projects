# frozen_string_literal: true

require_relative 'board.rb'
require_relative 'game.rb'
require_relative 'display.rb'

def play_game
  game = Game.new
  game.play
  repeat_game
end

def repeat_game
  puts 'Would you like to play again? (Y/N)'
  repeat_answer = gets.chomp.downcase
  if repeat_answer == 'y'
    play_game
  elsif repeat_answer == 'n'
    puts 'Thanks for playing.'
    exit
  else
    puts 'Please answer \"Y\" or \"N\".'
    repeat_game
  end
end

play_game
