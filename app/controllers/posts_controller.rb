class PostsController < ApplicationController
  load_and_authorize_resource

  before_action :user_signed_in?, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build post_params

    if @post.save
      #render json: {status: :success, html: render_to_string(@post)}
      flash[:success] = t ".post_created!"
      redirect_to root_url
    else
      render json: {status: :fail}
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t ".post_deleted"
    else
      flash[:warning] = t ".post_deleted_fail"
    end

    redirect_to request.referrer || root_url
  end

  private

  def post_params
    params.require(:post).permit :title, :content, :picture
  end

  def correct_user
    @post = current_user.posts.find_by id: params[:id]
    redirect_to root_url if @post.nil?
  end
end
