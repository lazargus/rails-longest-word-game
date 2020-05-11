require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def score
    word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = open(url).read
    dico = JSON.parse(user_serialized)
    if word.chars.all? { |letter| word.chars.count(letter) <= params[:letters].count(letter) } == false
      grid = params[:letters].gsub(' ', ', ')
      @word = "Sorry but #{word.upcase} can't be built out of #{grid}"
    elsif dico['found'] == false
      @word = "Sorry but #{word.upcase} does not seem a valid English word... "
    else
      @word = "Congratulations! #{word.upcase} is a valid English word!"
    end
  end
end
