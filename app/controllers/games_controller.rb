require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { (('A'..'Z').to_a).sample }
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split
    @included = included?(@word, @letters)
    @valid_word = english_word?(@word)
  end

  def included?(input, letters)
    input.chars.all? { |letter| input.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    words = URI.open(url).read
    result = JSON.parse(words)

    result['found'] == true
  end
end
