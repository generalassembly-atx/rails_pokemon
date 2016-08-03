class PokemonsController < ApplicationController

  def index
    @pokemons = Pokemon.all
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end

  def new
    @pokemon = Pokemon.new
  end

  def create

    def create
      @pokemon = Pokemon.new
      @pokemon.name = params["pokemon"]["name"]
      @pokemon.kind = params["pokemon"]["kind"]
      @pokemon.number = params["pokemon"]["number"]
      @pokemon.save

      redirect_to @pokemon
    end
  end

end
