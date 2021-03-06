require 'sinatra/base'
require_relative './lib/game'
require_relative './lib/player'
require_relative './lib/computer'

class RPS < Sinatra::Base

  before do
    @game = Game.instance
  end

  get '/' do
    erb(:index)
  end

  post '/player-form' do
    @game = Game.create(Player.new(params[:player1]), Computer.new)
    redirect '/play'
  end

  get '/play' do
    erb(:play)
  end

  post '/move' do
    @game.player1_chooses(params[:move].downcase.to_sym)
    @game.computer_chooses
    redirect '/outcome'
  end

  get '/outcome' do
    (@game.outcome != :draw) ? @outcome = "#{@game.outcome} Wins!" : @outcome = "It's a draw"
    erb(:outcome)
  end
end
