class UsersController < ApplicationController

  def show
    if current_user
      respond_to do |format|
        format.html
        format.json { render :json => current_user }
      end
    else
      redirect_to signin_path
    end
  end

end
