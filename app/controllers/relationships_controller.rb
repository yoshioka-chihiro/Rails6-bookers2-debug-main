class RelationshipsController < ApplicationController
  # フォローするとき
  def create
    # user_idがfollowed_idとなる
    # user_followings GET /users/:user_id/followings(.:format) だからだよ！
    @user = User.find(params[:user_id])
    @current_user = current_user
    current_user.follow(params[:user_id])
    # redirect_to request.referer
    render 'index'
  end
  # フォロー外すとき
  def destroy
    # user_idがfollowed_idとなる
    @user = User.find(params[:user_id])
    @current_user = current_user
    current_user.unfollow(params[:user_id])
    # redirect_to request.referer
    render 'index'
  end

  # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end

end
