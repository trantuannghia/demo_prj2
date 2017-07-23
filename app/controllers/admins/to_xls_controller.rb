class Admins::ToXlsController < ApplicationController
  def index
   @users = User.to_xls
    respond_to do |format|
      format.html
      format.xls {
        send_data @users, :filename => 'users.xls'
        return admins_statistic_url
      }
    end
  end
end
