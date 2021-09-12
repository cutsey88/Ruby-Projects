# frozen_string_literal: true

# Contains messages to diplay to the player.

module Display

  def display_welcome_message
    <<~HEREDOC
      Hangman is the name of the game.
      Guess one letter at a time to try and fill out the word.
      If you get 6 wrong, you're hanged, man.
      Enter 'new' to play a new game or 'old' to load a saved one.
    HEREDOC
  end

  def display_correct_guesses(guesses, dashes)
    <<~HEREDOC
           #{guesses}
           #{dashes}
      --------------------------------
    HEREDOC
  end

  def display_wrong_guesses(guesses)
    <<~HEREDOC
           
      Wrong Guesses: #{guesses}
      --------------------------------
    HEREDOC
  end

  def display_win_message(word)
    "Well done! The word is : #{word}"
  end

  def display_loss_message(word)
    "Sorry, you lose. The correct word is : #{word}."
  end
end