require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.shuffle[1..10]
  end

  def score
    @word = params[:word]
    @letters = params[:letters]

    @include = @word.split(//).all? { |letter| @letters.include?(letter) }
    @valid = check_word(@word)
    @score = @word.length * 10
  end

  private

  def check_word(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
