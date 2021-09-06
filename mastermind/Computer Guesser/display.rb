# frozen_string_literal: true

# Text for Mastermind
module Display
  def display_intro
    puts <<~HEREDOC
      Welcome to Mastermind!
      Test your brainpower and see if you can crack your opponents code
      or fool them with your own.
      -The Mastermind enters four colors (colors can be repeated) to make a code.
      -The Guesser enters four colors to try and
       match their opponent's code to win.
      -The Guesser gets 12 tries for glorious victory.

      Do you want to be the Guesser (Y/N)?
    HEREDOC
  end

  def display_guess_prompt
    'Please enter a guess. Valid colors are red, '\
    'orange, yellow, green, blue, and purple.'
  end

  def display_code_pick_prompt
    'Please enter a code of four words. Valid colors are red, '\
    'orange, yellow, green, blue, and purple.'
  end

  def display_number_of_matches(perfect, imperfect)
    "You made #{perfect} perfect matches and #{imperfect} imperfect matches."
  end

  def display_win_message
    'You win. Congratulatons, you Mastermind!'
  end

  def display_lose_message
    'Looks like you aren\'t the Mastermind we were looking for.'
  end
end
