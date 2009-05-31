require 'rfeedparser'

class MainController < ApplicationController
  def index
    @clocked_in_users=User.clocked_in
    @clocked_out_users=User.clocked_out
    cache_id=Time.zone.now.strftime("feed-%Y-%m-%d-%H-")+((Time.zone.now.strftime("%M").to_i / 20).round * 20).to_s
    @feed = Rails.cache.fetch(cache_id) do
        FeedParser.parse(LACONICA_URI)
    end  
  end

end
