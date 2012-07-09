class UsersController < ApplicationController
  def welcome_page

  end

  def profile_settings

  end
  
  def edit_profile
    @user = User.find(params[:id])
    if request.put?
      if @user.update_attributes(params[:user])
        redirect_to show_profile_path(@user.id), :notice => "Editing done Successfully"
      else
        render :edit_profile
      end
    end
  end

  def change_password
    @user = current_user
    #    @password = User.find_by_email(params[:user][:email])
    if request.put?
      if @user.valid_password?(params[:user][:old_password])
        @user.password = params[:user][:password]
        if @user.save
          redirect_to users_profile_settings_path, :notice => "Password Changed Successfully"
        else
          render :change_password
        end
      else
        render :change_password
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def add_friend
    if request.post?
#      @user = current_user
#      friend = Friends.find(params[:friend_id])
#      @friend = @user.friends << friend
      current_user.friends.build(:user_id => current_user.id, :friend_id => params[:friend_id])
      current_user.save
      respond_to do |format|
        
        format.js 
        
      end

    end

  end

  def socialbook_users
    users = []
    users << current_user.id
    users << current_user.friends.map(&:friend_id)
    users.flatten!
    @user = User.where(["id not in (?)",users])
    @users = User.paginate :page => (params[:page]), :per_page => 6
  end

  def friends_list
    @friends = User.find(current_user.friends.map(&:friend_id))
    @users = User.paginate :page => (params[:page]), :per_page => 6
  end

end
