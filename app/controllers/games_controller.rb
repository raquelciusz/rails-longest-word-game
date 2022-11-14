class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { [*'A'..'Z'].sample }
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    json = JSON.parse(response)

    @letters = params[:letters].gsub(/\s+/, "")
    @word = params[:word].upcase
    @word = @word.split(//)
    @word.each do |l|
      deletando = @letters.slice!(l)
      if deletando.nil?
        @result = "Sorry but #{params[:word]} cant be built out of #{@letters}"
      elsif json['found'] == false
        @result = "Sorry but #{params[:word]} does not seem to be a valid English word"
      else
        @result = "Congratulations! #{params[:word]} is a valid English word!"
      end
    end
  end
end
