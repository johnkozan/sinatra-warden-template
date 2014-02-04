# main requires
require "sinatra"
require "slim"
require "warden"
require "rack-flash"

# require models 
require_relative "models/init"

# main class
module Castivo
  class SMS < Sinatra::Base
    # enabling sessions and configuring flash
    use Rack::Session::Cookie, secret: "IdoNotHaveAnySecret"
    use Rack::Flash, accessorize: [:error, :success]

    # configuration
    # warden configuration
    use Warden::Manager do |config|
      # serialize user to session ->
      config.serialize_into_session{|user| user.id}
      # serialize user from session <-
      config.serialize_from_session{|id| User.get(id) }
      # configuring strategies
      config.scope_defaults :default, strategies: [:password], action: 'auth/unauthenticated'
      # 
      config.failure_app = self
    end

    # redirect method for POST
    Warden::Manager.before_failure do |env,opts|
      env['REQUEST_METHOD'] = 'POST'
    end

    # implement warden strategies
    Warden::Strategies.add(:password) do
      # flash is not reached 
      # we create a wrap
      def flash
        env['x-rack.flash']
      end

      # valid params for authentication
      def valid?
        params['user'] && params['user']['username'] && params['user']['password']
      end

      # authenticating user
      def authenticate!
        # find for user
        user = User.first(username: params['user']['username'])
        
        if user.nil?
          fail!("Invalid username, doesn't exists!")
          flash.error = ""
        elsif user.authenticate(params['user']['password'])
          flash.success = "Logged in"
          success!(user)
        else
          fail!("There are errors, please try again")
        end

      end

    end

  end
end 
# require routes
require_relative "routes/init"

