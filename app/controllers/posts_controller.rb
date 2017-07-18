class PostsController < ApplicationController
  before_action :user_signed_in?, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build post_params
    @post.content.gsub! "\r\n", "<br>"
    title = @post.title
    array_tag = []
    array_title = []
    array = title.split();
    array.each do |text|
      array2 = text.scan("#")
      if(array2.length >= 1)
        array3 = text.split("#")
        array_tag = array_tag + array3
      else
        array_title = array_title << text
      end
    end
    string_title = array_title.join(" ")
    @post.title = string_title
    array_tag = array_tag.select {|val| val != ""}

    if @post.save
      array_tag.each do |val|
        tag = Tag.find_or_initialize_by(name: val)
        tag.save
        PostTag.find_or_create_by(post_id: @post.id, tag_id: tag.id)
      end
      flash[:success] = t ".post_created!"
      redirect_to root_url
    else
      render json: {status: :fail}
    end
  end

  def destroy
    @post.destroy
    flash[:success] = t ".post_deleted"
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
