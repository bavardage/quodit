class QuotesController < ApplicationController

  def index
    @wall = Wall.find(params[:wall_id])
    @quotes = @wall.quotes
  end
  
end
