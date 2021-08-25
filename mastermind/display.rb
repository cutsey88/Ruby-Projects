# frozen_string_literal: true

# Text for Mastermind
module Display
  def display_intro
    puts <<~HEREDOC
      Welcome to Mastermind!
      Test your brainpower and see if you can crack your opponents code.
      Enter four colors (you can repeat) to try and match your opponents code.
      You will get 12 tries for glorious victory.
    HEREDOC
  end

  def display_guess_prompt
    'Please enter a guess. Valid colors are red, '\
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
