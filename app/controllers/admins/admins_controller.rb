class Admins::AdminsController < ApplicationController
  before_action :authenticate_user!, :verify_admin!
  def index
    @post = Post.all
  end

  def statistic
    @post_count = {post_count: Post.all.size,
      post_count_day: Post.all.created_on_day.size,
      post_count_week: Post.all.created_on_week.size,
      post_count_month: Post.all.created_on_month.size}
    @user_count = {user_count: User.all.size, user_week: User.all.create_on_week.size}
  end

  private

  def verify_admin!
    redirect_to root_url unless current_user.is_admin?
  end
end
