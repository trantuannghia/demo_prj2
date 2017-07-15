class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :load_user, only: :show

  def index
    @users = User.select(:id, :name, :email).page(params[:page]).per Settings.controller.pre_page
  end

  def show
    @posts = @user.posts.order_by_desc.page(params[:page]).per Settings.controller.pre_page
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".find_rerror"
    redirect_to root_url
  end
end
