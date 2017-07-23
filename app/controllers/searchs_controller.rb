class SearchsController < ApplicationController
   def index
    @users = User.search(params[:term]).order_by_email
    render json: @users.map{|user| email: user.email}
  end
end
