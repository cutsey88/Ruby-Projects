require_relative 'board'
require_relative 'player'

class Game
  attr_accessor :current_player, :board
  attr_reader :player_one, :player_two
  def initialize
    @board = Board.new
    @player_one = 'X'
    @player_two = 'O'
    @current_player = player_one
  end
  
  def intro
    puts <<~INTRO
      Welcome to Connect Four. Place your piece in the slots and get four
      in a row before your opponent to win. Any which way goes: Horizontally,
      Vertically, or Diagonally. Just type the number of the column to drop
      your piece.

    INTRO
  end

  def play
    intro
    until game_over?
      board.show_board
      display_player_turn
      play_turn
      player_shift unless game_over?
    end
    after_win
  end

  def display_player_turn
    puts "It's #{current_player}'s turn."
    puts 'Choose a column to drop your piece into.'
  end

  def play_turn
    column_index = player_input - 1
    place_piece(column_index)
  end

  def place_piece(column_input)
    open_spot = board.spaces[column_input].find_index(nil)
    if board.spaces[column_input][-1].nil?
      self.board.spaces[column_input][open_spot] = current_player
    else
      puts 'This column is full. Choose another.'
      play_turn
    end
  end

  def player_input
    input = gets.chomp.to_i
    if input.between?(1, 7)
      input
    else
      puts 'Please enter a valid column number.'
      player_input
    end
  end

  def player_shift
    current_player == player_one ? self.current_player = player_two : self.current_player = player_one
  end

  def game_over?
    if check_column_win || check_row_win || check_diag_win
      true
    else
      false
    end
  end

  def check_column_win
    win = false
    board.spaces.each do |column|
      win_options = [column[0..3], column[1..4], column[2..5]]
      win_options.each do |option|
        if option.all? { |spot| spot == player_one } || option.all? { |spot| spot == player_two }
          win = true
          break
        end
      end
    end
    win
  end

  def check_row_win
    win = false
    for i in 0..5
      row = board.spaces.map { |column| column[i] }
      win_options = [row[0..3], row[1..4], row[2..5], row[3..6]]
      win_options.each do |option|
        if option.all? { |spot| spot == player_one } || option.all? { |spot| spot == player_two }
          win = true
          break
        end
      end
    end
    win
  end

  def check_diag_win
    check_upleft_to_downright_win || check_upright_to_downleft_win ? true : false
  end

  def check_upleft_to_downright_win
    win = false
    board.spaces.each_with_index do |column, out_index|
      next if out_index > 3

      column.each_with_index do |space, in_index|
        next if in_index < 3

        win_option = [space, board.spaces[out_index + 1][in_index - 1], board.spaces[out_index + 2][in_index - 2], board.spaces[out_index + 3][in_index - 3]]
        if win_option.all? { |spot| spot == player_one } || win_option.all? { |spot| spot == player_two }
          win = true
          break
        end
      end
    end
    win
  end

  def check_upright_to_downleft_win
    win = false
    board.spaces.each_with_index do |column, out_index|
      next if out_index > 3

      column.each_with_index do |space, in_index|
        next if in_index > 2

        win_option = [space, board.spaces[out_index + 1][in_index + 1], board.spaces[out_index + 2][in_index + 2], board.spaces[out_index + 3][in_index + 3]]
        if win_option.all? { |spot| spot == player_one } || win_option.all? { |spot| spot == player_two }
          win = true
          break
        end
      end
    end
    win
  end

  def check_win_options(options)
    win_options.each do |option|
      if option.all? { |spot| spot == player_one } || option.all? { |spot| spot == player_two }
        win = true
        break
      end
    end
  end

  def after_win
    board.show_board
    display_win_message
    play_again
  end

  def display_win_message
    puts "Yay! #{current_player} wins!"
    puts 'Play again? (Y/N)'
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

  def replay
    @board = Board.new
    @player_one = 'X'
    @player_two = 'O'
    @current_player = player_one
    play
  end
end
