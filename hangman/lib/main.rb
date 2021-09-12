# frozen_string_literal: true

require_relative 'game.rb'
require_relative 'display.rb'
include Display

def play_game
  game = Game.new
  puts display_welcome_message
  game.select_game_type
  play_again
end

def play_again
  puts 'Would you like to play again? (Y/N)'
  repeat_answer = gets.chomp.downcase
  if repeat_answer == 'y'
    play_game
  elsif repeat_answer == 'n'
    puts 'Thanks for playing.'
    exit
  else
    puts 'Please answer \"Y\" or \"N\".'
    play_again
  end
end

play_game
