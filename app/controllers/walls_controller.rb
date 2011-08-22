class WallsController < ApplicationController

  def new
    @wall = Wall.new
  end
  
  def index 
    current_user.membered_walls
  end
  
  def show
    @wall = Wall.find(params[:id])
  end

  def create
    @wall = Wall.new params[:wall]
    admin_membership = Membership.new :user => current_user, :wall => @wall, :role => "admin"
    admin_membership.save

    membership = Membership.new :user => current_user, :wall => @wall, :role => "member"
    membership.save

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

  def edit
    @wall = Wall.find(params[:id])
  end

  def update
    @wall = Wall.find(params[:id])
    @wall.update_attributes(params[:wall])
    
    respond_to do |format|
      if @wall.save
        format.html do
          redirect_to wall_path(@wall)
        end
        format.json { render :json => true }
      else
        format.html { render :action => "edit", flash[:notice] => "Could not update wall" }
        format.json do
          @obj = wall
          render "layouts/errors.json"
        end
      end
    end
  end

  def request_membership
    @wall = Wall.find(params[:id])
    
    if current_user.has_role(@wall, "member")
      redirect_to wall_path(@wall)
    else
      request = Membership.new :user => current_user, :wall => @wall, :role => "request"
      request.save
    end
  end

  def autocomplete_member
    members = User.where(["name like ?", "%#{params[:search]}%"]).joins(:memberships).where(:memberships => {:wall_id => params[:id], :role => "member"})

    json = []
    
    members.each do |m|
      json << {:label => m.name, :value => m.uid}
    end

    # current_user.facebook_user(session[:token]).friends.each do |f|
    #   json << {:label => f.name, :value => f.id }
    # end

    respond_to do |format|
      format.json { render :json => json }
      format.html { render :json => json }
    end
  end

  def invite_facebook
    uid = params["uid"]
    user = User.create_user(uid, "facebook")
  end
end
