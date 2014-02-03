# main requires
require "sinatra"
require "slim"
require "sinatra/flash"
require "sinatra/reloader" if development?

# main class
module Castivo
  class SMS < Sinatra::Base
    # enabling sessions and configuring flash
    enable :sessions
    register Sinatra::Flash

    # configuration
    configure :development do
      register Sinatra::Reloader
    end

  end
end 


# require relatives
require_relative "models/init"
require_relative "routes/init"

