require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @grid = (Array('A'..'Z')).shuffle[0,15].join
  end

  def score
    @word = params[:word]
    @grid = params[:grid_letters]
    @start_time = Time.now
    @end_time = Time.now

    filepath = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_check = open(filepath).read
        @score_hash = Hash.new
       json = JSON.parse(word_check)
       json.each do |element|
         if (json["found"] == true && find_chars(@grid, @word) == true) # Need to validate the letters entered match grid
           @score_hash[:word] = @word
           @score_hash[:time] = @end_time - @start_time
           if @score_hash[:time] <= 3
               @score_hash[:score] = json["length"] + 3
             else
               @score_hash[:score] = json["length"]
             end
           @score_hash[:message] = "well done"
         elsif json["found"] == false
           @score_hash[:word] = @word
           @score_hash[:score] = 0
           @score_hash[:time] = @end_time - @start_time
           @score_hash[:message] = "Sorry, the word you entered is not an English word."
         else
          @score_hash[:word] = @word
           @score_hash[:score] = 0
           @score_hash[:time] = @end_time - @start_time
           @score_hash[:message] = "Sorry, the word you entered is not in the grid."
        end
      end
    return @score_hash
  end
  def find_chars(grid, word)
  @try = @word.upcase.chars.all? do |char|
   @word.upcase.count(char) <= grid.count(char)
 end
 return @try
end
end
