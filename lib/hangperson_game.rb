class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    return self
  end

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def guess(letter)
    raise ArgumentError, 'Argument is nil' if letter.nil? #Must be first
    raise ArgumentError, 'Argument is empty' if letter.empty? 
    raise ArgumentError, 'Argument is not a letter' if /\W/.match(letter)
    letter.downcase!
    if @word.include? letter
      if not @guesses.include? letter
        @guesses << letter
      else
        return false
      end
    else
      if not @wrong_guesses.include? letter
        @wrong_guesses << letter
      else
        return false
      end
    end
  end
  
  def word_with_guesses
    display = ''
    word = @word.split(//)
    word.each do |letter|
      if @guesses.include? letter
        display << letter
      else
        display << '-'
      end
    end
    return display
  end
  
  def check_win_or_lose
    if wrong_guesses.size >= 7
      return :lose
    elsif word_with_guesses == @word
      return :win
    else
      return :play
    end
  end
    
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
