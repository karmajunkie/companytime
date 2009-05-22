class MainController < ApplicationController
  def index
    @clocked_in_users=User.clocked_in
    @clocked_out_users=User.clocked_out
  end

end
