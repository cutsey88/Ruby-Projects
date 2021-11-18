# frozen_string_literal: true

class TicTacToeBoard
  attr_accessor :row_a, :row_b, :row_c, :input, :turn_counter
  
  def initialize
    @turn_counter = 0
    @input = "X"
    @row_a = [1, 2, 3]
    @row_b = [4, 5, 6]
    @row_c = [7, 8, 9]
  end

  def show_grid
    puts <<~HEREDOC
      #{row_a[0]} | #{row_a[1]} | #{row_a[2]}
      --+---+--
      #{row_b[0]} | #{row_b[1]} | #{row_b[2]}
      --+---+--
      #{row_c[0]} | #{row_c[1]} | #{row_c[2]}
    HEREDOC
  end

  def make_move
    move = gets.chomp.to_i
    
    case move
    when 1
      if row_a[0].is_a?(Integer)
        row_a[0] = input
      else
        display_valid_number
      end
    when 2
      if row_a[1].is_a?(Integer)
        row_a[1] = input
      else
        display_valid_number
      end
    when 3
      if row_a[2].is_a?(Integer)
        row_a[2] = input
      else
        display_valid_number
      end
    when 4
      if row_b[0].is_a?(Integer)
        row_b[0] = input
      else
        display_valid_number
      end
    when 5
      if row_b[1].is_a?(Integer)
        row_b[1] = input
      else
        display_valid_number
      end
    when 6
      if row_b[2].is_a?(Integer)
        row_b[2] = input
      else
        display_valid_number
      end
    when 7
      if row_c[0].is_a?(Integer)
        row_c[0] = input
      else
        display_valid_number
      end
    when 8
      if row_c[1].is_a?(Integer)
        row_c[1] = input
      else
        display_valid_number
      end
    when 9
      if row_c[2].is_a?(Integer)
        row_c[2] = input
      else
        display_valid_number
      end
    else
      display_valid_number
    end
    self.turn_counter += 1
  end

  def display_valid_number
    puts 'Please enter a valid number.'
    self.turn_counter -= 1
    make_move
  end
  def check_winner
    if row_a[0] == input && row_a[1] == input && row_a[2] == input ||
       row_b[0] == input && row_b[1] == input && row_b[2] == input ||
       row_c[0] == input && row_c[1] == input && row_c[2] == input ||
       row_a[0] == input && row_b[0] == input && row_c[0] == input ||
       row_a[1] == input && row_b[1] == input && row_c[1] == input ||
       row_a[2] == input && row_b[2] == input && row_c[2] == input ||
       row_a[0] == input && row_b[1] == input && row_c[2] == input ||
       row_a[2] == input && row_b[1] == input && row_c[0] == input
      true
    else
      false
    end
  end

  def check_tie
    if row_a[0].is_a?(String) && row_a[1].is_a?(String) && row_a[2].is_a?(String) &&
       row_b[0].is_a?(String) && row_b[1].is_a?(String) && row_b[2].is_a?(String) &&
       row_c[0].is_a?(String) && row_c[1].is_a?(String) && row_c[2].is_a?(String)
      true
    else
      false
    end
  end

  def play_again
    try_again = gets.chomp.downcase
    if try_again == 'y' || try_again == 'yes'
      replay
    elsif try_again == 'n' || try_again == 'no'
      puts 'Thanks for playing.'
      exit
    else
      puts 'Please say Y or N.'
      play_again
    end
  end

  def shift_input
    if turn_counter.even?
      self.input = 'X'
    else
      self.input = 'O'
    end
  end

  def replay
    @turn_counter = 0
    @input = 'X'
    @row_a = [1, 2, 3]
    @row_b = [4, 5, 6]
    @row_c = [7, 8, 9]
    intro
    play
  end

  def intro
    puts 'Welcome to a friendly game of Tic-Tac-Toe.\nX goes first.'
    puts 'Please enter a number from the grid to make your move.'
    show_grid
    make_move
  end

  def play
    if check_winner
      show_grid
      puts "#{input} won the game! Do you want to try again? (Y/N)"
      play_again
    elsif check_tie
      puts 'It\'s a tie. How anticlimactic. Try again? (Y/N)'
      play_again
    else
      show_grid
      shift_input
      puts "It's #{input}'s turn."
      make_move
      play
    end
  end
end
