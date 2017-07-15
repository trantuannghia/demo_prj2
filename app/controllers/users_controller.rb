class UsersController < ApplicationController
  before_action :load_user, only: :show

  def index
    @users = User.where(activated: true)
      .select(:id, :name, :email).paginate page: params[:page],
      per_page: Settings.controller.user_controller.size_page
  end

  def show
    @posts = @user.posts.paginate page: params[:page]
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".find_rerror"
    redirect_to root_url
  end

end
