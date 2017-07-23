class StaticPagesController < ApplicationController

  def home
    if user_signed_in?
     @feed_items = current_user.feed.order_by_desc.page(params[:page]).per Settings.controller.per_page
     @comment = Comment.new
    end
  end
end
