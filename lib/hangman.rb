class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses,

  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, '_')
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
  indices = []
    @secret_word.each_char.with_index do |ele, i|
      indices << i if char == ele
    end
    indices
  end

  def fill_indices(char, array)
    array.each do |ele|
      @guess_word[ele] = char
    end
  end

  def try_guess(char)
    if self.already_attempted?(char)
      p "that has already been attempted"
      return false
    end

    @attempted_chars << char

    ans = self.get_matching_indices(char)
    if ans.empty?
      @remaining_incorrect_guesses -=1
    else
      self.fill_indices(char, ans) 
    end
    true
  end

  def ask_user_for_guess
    p "Enter a char:"
    char = gets.chomp
    self.try_guess(char)
  end

  def win?
    if @secret_word == @guess_word.join("")
      p "WIN"
      return true
    end
    false
  end

  def lose?
    return false if @remaining_incorrect_guesses != 0
    p "LOSE"
    true
  end

  def game_over?
    if self.win? || self.lose?
      p @secret_word 
      return true
    end
    false
  end

end
