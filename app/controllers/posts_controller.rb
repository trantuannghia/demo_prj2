class PostsController < ApplicationController
  load_and_authorize_resource

  before_action :user_signed_in?, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy, :edit, :update]

  def index
    search = params[:search].gsub "%", "\\%"

    if search.index("#") == 0
      tag = Tag.all.find_by name: search.gsub("#", "")

      if tag.nil?
         flash.now[:warning] = t ".no_find_any_post_success"
         redirect_to request.referrer
      else
        @posts = tag.posts.order_by_desc.page params[:page]
      end

    else
      @posts = Post.all.search_post(search).order_by_desc.page params[:page]
      if @posts.size == 0
        flash.now[:warning] = t ".no_find_any_post_success"
      end
    end
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find_by id: params[:id]
  end

  def create
    @post = current_user.posts.build post_params
    @post.content = @post.content.gsub "\r\n", "<br>"
    @post.content = @post.content.gsub "%", "\\%"
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
      flash[:warning] = t ".content_missing"
      redirect_to root_url
    end
  end


  def edit
    render json: {status: :success, html: render_to_string(partial: "shared/edit_form_post")}
  end

  def update
    contents = params[:post][:content].gsub("\r\n", "<br>")
    if @post.update_attributes title: params[:post][:title], content: contents
      flash[:success] = t ".updated"
      redirect_to root_url
    else
      flash.now[:danger] = t ".fail_update"
      redirect_to root_url
    end
  end

  def search
    if params[:search] == ""
      render json: {status: :success, html: ""}
    else
      @posts = Post.search_post(params[:search])
      textjson = ""
      @posts.each do |post|
        contents = post.content.gsub("<br>", "\r\n")
        idx = contents.index(params[:search])
        if idx > 20
          textjson << "<li>.."+contents[idx-20,idx+20]+"..</li>"
        else
          textjson << "<li>.."+contents[idx,idx+30]+"..</li>"
        end
      end
      render json: {status: :success, html: textjson}
    end
  end

  def destroy
    if @post.destroy
      render json: {status: :success}
    else
      render json: {status: :error}
    end
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
