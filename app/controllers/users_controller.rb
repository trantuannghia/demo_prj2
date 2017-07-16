class UsersController < ApplicationController
  before_action :load_user, except: :index

  def index
    @users = User.select(:id, :name, :email).page params[:page]
  end

  def show
    @posts = @user.posts.page(params[:page]).per 10
  end

  def following
    @title = "Following"
    @users = @user.following.page params[:page]
    render "show_follow"
  end

  def followers
    @title = "Followers"
    @users = @user.followers.page params[:page]
    render "show_follow"
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".find_rerror"
    redirect_to root_url
  end

end
