class QuotesController < ApplicationController

  def index
    @wall = Wall.find(params[:wall_id])
    @quotes = @wall.quotes
  end
  
  def destroy
   
    @quote = Quote.find(params[:id])
    if (@quote.author == current_user)
      @quote.destroy
    end
    respond_to do |format|
      format.html { redirect_to(Wall.find(params[:wall_id]) }
    end
  end 

  def new
    @wall = Wall.find(params[:wall_id])
    @quote = Quote.new
  end
end
