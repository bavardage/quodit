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
      format.html { redirect_to wall_path(@quote.wall) }
    end
  end 

  def new
    @wall = Wall.find(params[:wall_id])
    @quote = Quote.new
  end

  def create
    @wall = Wall.find(params[:wall_id])
    @quote = Quote.new params[:quote]
    
    @quote.author = current_user
    @quote.wall = @wall

    #TODO: should also here extract tagged users!

    respond_to do |format|
      if @quote.save
        format.html { redirect_to wall_path(@wall) }
        format.json { render :json => @quote }
      else
        format.html { render :action => :new }
        format.json { @obj = wall; render "layouts/errors.json" }
      end
    end
  end
end
