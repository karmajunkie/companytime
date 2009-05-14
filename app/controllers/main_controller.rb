class MainController < ApplicationController
  def index
    @users=User.valid_users
  end

end
