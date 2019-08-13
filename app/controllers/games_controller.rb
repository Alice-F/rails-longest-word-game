require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    array_of_every_letters = ('a'..'z').to_a
    @array_of_ten_letters_random = array_of_every_letters.sample(10)
    # ["q", "l", "t", "s", "h", "b", "c", "e", "o", "m"]
  end

  def score
    @user_mot = params[:mot]
    @user_mot_array = @user_mot.split("")
    # ["a", "l", "i", "c", "e"]

    @array_of_ten_letters_random1 = params[:letters].split
    # c'est la même que @array_of_ten_letters_random mais on ne pouvait le récupérer dans score que via la balise html dans new <%= hidden_field_tag :letters, @array_of_ten_letters_random %> et on est obligé de le retraiter du coup.
    @user_mot_array.each do |user_letter|
      @result = @array_of_ten_letters_random1.include?(user_letter)
        # if array_of_ten_letters_random.include?(user_letter) == true
        #   @result = true
        # else
        #   @result = false
        # end
    end

    # cours sur le parse
    url = "https://wagon-dictionary.herokuapp.com/#{@user_mot}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized) # {"found"=>true, "word"=>"welcome", "length"=>7}
    @result_API_exist = user["found"]
    @result_API_longueur_mot = user["length"]

    @result = @result & @result_API_exist
    raise
  end
end
