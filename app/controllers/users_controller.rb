class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :load_user, except: :index

  def index
    @users = User.select(:id, :name, :email).page(params[:page]).per Settings.controller.pre_page
  end

  def show
    @posts = @user.posts.order_by_desc.page(params[:page])
      .per Settings.controller.user_controller.size_page
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

  def destroy
    if @user.destroy
      flash[:success] = t ".user_delete"
    else
      flash[:success] = t ".error"
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".find_rerror"
    redirect_to root_url
  end
end
