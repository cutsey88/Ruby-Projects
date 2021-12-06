module Display
  def wrong_length_message
    'This input is too long. Try again.'
  end

  def wrong_char_message
    'Please type two numbers representing a space on the board.'
  end

  def not_on_board_message
    'This space doesn\'t exist. Please type two valid numbers.'
  end

  def no_piece_message
    'There is no piece in this space. Try again.'
  end

  def not_your_piece_message
    'This is not your piece. Try again.'
  end
end