require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    array_of_letters = ('a'..'z').to_a
    @letters = array_of_letters.shuffle.first(10)
  end

  def score
    @final = ""
    @answer = params[:answer].to_s.downcase
    @letters = params[:letters].to_s.remove(' ')

    @answer.split(//).each do |single_letter|
      if @letters.split(//).include?(single_letter) == true
        @letters.delete(single_letter)
      else
        @filter = "your word is not included in the instructions"
      end
    end
    @filter = "your word is included in the instructions"
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    json = open(url).read
    @hash = JSON.parse(json)
    if @hash["found"] == true
      @final = "word is english"
    else
      @final = "word is pas english"
    end
  end
end
