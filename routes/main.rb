#
# Main routing
#
module Castivo
  class SMS < Sinatra::Base
    # site index
    get "/" do
      slim :index
    end
  
    # not found catch
    not_found do
      slim :fourofour
    end
   
    # security
    post "/authorize" do

    end

  end
end
