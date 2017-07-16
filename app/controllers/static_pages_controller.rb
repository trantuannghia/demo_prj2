class StaticPagesController < ApplicationController

  def home
    if user_signed_in?
      @post  = current_user.posts.build
     @feed_items = current_user.feed.order_by_desc.page(params[:page]).per Settings.controller.per_page
    end
  end
end
