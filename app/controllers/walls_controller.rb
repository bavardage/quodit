class WallsController < ApplicationController

  def new
    @wall = Wall.new
  end

  def create
    @wall = Wall.new params[:wall]
    @wall.users << current_user

    respond_to do |format|
      if @wall.save
        format.html do
          redirect_to wall_path(@wall)
        end
        format.json { render :json => @wall }
      else
        format.html { render :action => "new", flash[:notice] => "Could not create wall" }
        format.json do
          @obj = wall
          render "layouts/errors.json"
        end
      end
    end
  end
end
