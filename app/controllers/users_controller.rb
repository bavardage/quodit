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

  def facebook_friends
    respond_to do |format|
      format.json { render :json => current_user.facebook_user(session[:token]).friends }
    end
  end

end
