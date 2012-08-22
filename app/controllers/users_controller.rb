class UsersController < ApplicationController
  def welcome_page
    @post = current_user.posts.build

    user = []
    user << current_user.id
    user << current_user.friends.map(&:friend_id)
    user.flatten!
    @posts = Post.user_friends_post(user)
    
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

    respond_to do |format|
      format.html
      format.js
    end
  end

  
  def friends_profile
    user = []
    @user = User.find(params[:id])
    user << current_user.id
    user << @user.id
    user.flatten!
    @mutual_friends = User.select('u.firstname').where(['f.user_id in (?)',user]).
                      joins('as u inner join friends as f on f.friend_id = u.id').
                      group('friend_id having count(friend_id) >= 2')
    
  end

  def post_status_update
    @friend = []

    if request.post?
      @post = current_user.posts.build(params[:post])
      @post.save
      @friend = User.find(current_user.friends.map(&:friend_id))
      Notifier.post_updated(@post,@friend).deliver
    end

    respond_to do |format|
      format.js
    end
  end

  def post_comment
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
    

    if request.post?
     
#      @comment = @post.comments.build(params[:comment])
#      @comment.save

       @comment = Comment.create(params[:comment].merge(:user_id => current_user.id, :post_id => @post.id))
       Notifier.comment_made(@post).deliver
    end

    respond_to do |format|
      format.js
      format.html
    end
    
  end

  def like
    @like = Like.create(:likeable_id => params[:likeable_id], :likeable_type => params[:likeable_type], :user_id => current_user.id)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def dislike
    @dislike = Like.find(params[:id])
    @likeable = @dislike.likeable
    
    @likeable_id = @dislike.likeable_id    
    @likeable_type = @dislike.likeable_type
    @dislike.destroy
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  def like_list
    if params[:likeable_type] == "Post"
      @like_list = Post.find(params[:likeable_id])
    else
      @like_list = Comment.find(params[:likeable_id])
    end

    render :layout => false
    
#
#    @like_list = User.select('u.firstname,l.likeable_type,l.likeable_id').where('l.likeable_id in (?)', @like).
#                 joins('as u inner join likes as l on u.id = l.user_id').
#                 group('likeable_type,likeable_id')

  end

  def create_event

    @friends = User.find(current_user.friends.map(&:friend_id))
    @event = current_user.events.build

#    event_users = @event.event_users.build
    
    if request.post?
      params[:event][:event_users_attributes].delete_if {|x| x[:user_id] == "0" }     

      @event = Event.create(params[:event])

    end
  end

  def list_events

#    @event_list = Event.select('e.*').where('eu.user_id = (?)',current_user.id ).
#                  joins('as e inner join event_users as eu on e.id = eu.event_id')
#    if @event_list.empty?
#      render :text => "Event list empty...."
#    end
  end

  def share_a_post

    @share = Share.create(:post_id => params[:post_id], :sharer_id => current_user.id)

#    user = @share.Post.user_id
#    @shares = User.wall_share(user)

#    user1 = []
#    user2 = []
#    user = []
#    if Post.shares.map(&:user_id).include? current_user.id
#      user1 << current_user.friends.map(&:friend_id)
#      user2 << Post.user_id.friends.map(&:friend_id)
#      user = user1 & user2
#      puts "------------"
#      puts user.inspect
#
#      @shares = User.wall_share(user)
#    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def share_list
    @share_list = Share.where(:post_id => params[:post_id]).group(:sharer_id)
    
    @post = Post.find(params[:post_id])

    respond_to do |format|
      format.html
      format.js
    end
  end

end
