class TagsController < ApplicationController
  def show
    @tag = Tag.find_by id: params[:id]
    @post = @tag.posts.order_by_desc.select(:id, :content, :title, :user_id, :created_at).page(params[:page]).per 10
    if @post.nil?
      flash.now[:warning] = t ".no_find_any_post_success"
    end
  end
end
