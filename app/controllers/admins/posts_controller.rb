class Admins::PostsController < ApplicationController
  def index
    @posts = Post.all.order_by_desc.page(params[:page]).per 5
  end
end
