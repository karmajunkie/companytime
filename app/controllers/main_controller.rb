require 'rfeedparser'

class MainController < ApplicationController
  def index
    @clocked_in_users=User.clocked_in
    @clocked_out_users=User.clocked_out
    
    @feed = FeedParser.parse('http://keith.talho.org/api/statuses/public_timeline.atom')
  end

end
