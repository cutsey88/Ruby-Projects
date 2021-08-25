# frozen_string_literal: true

# Text for Mastermind
module Display
  def intro
    puts <<~HEREDOC
      Welcome to Mastermind!
      Test your brainpower and see if you can crack your opponents code.
      Enter four colors (you can repeat) to try and match your opponents code.
      You will get 12 tries for glorious victory.
    HEREDOC
  end

  def guess_prompt
    puts 'Please enter a guess. Valid colors are red, '\
    'orange, yellow, green, blue, and purple.'
  end

  def display_number_of_matches(perfect, imperfect)
    puts "You made #{perfect} perfect matches and #{imperfect} imperfect matches."
  end
end
