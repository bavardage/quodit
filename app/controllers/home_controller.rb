class HomeController < ApplicationController
  
  skip_before_filter :require_signed_in

  def index
    if current_user 
      redirect_to current_user
    end
  end
end
