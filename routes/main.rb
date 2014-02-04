#
# Main routing
#
module SST
  class SinatraWarden < Sinatra::Base
    # site index
    get "/" do
      slim :index
    end
  
    # not found catch
    not_found do
      slim :fourofour
    end
   
    get '/main' do
      env['warden'].authenticate!
      slim :main
    end

    # security
    # login
    get '/auth/login' do
      slim :login
    end
  
    post '/auth/login' do
      # call warden strategies
      env['warden'].authenticate!
      # warden message
      flash[:success] = env['warden'].message || "Successfull Login"
      # come from protected page ??
      if session[:return_to].nil?
        redirect "/main"
      else
        redirect session[:return_to]
      end
    end
 
    # accessing unauthenticated user to protected path
    post '/auth/unauthenticated' do
      session[:return_to] = env['warden.options'][:attempted_path]
      puts env['warden.options'][:attempted_path]
      flash[:error] = env['warden'].message  || 'You must to login to continue'
      redirect '/auth/login'
    end


    # logout
    get '/auth/logout' do
      env['warden'].raw_session.inspect
      env['warden'].logout
      flash[:success] = "Successfully logged out"
      redirect '/'
    end

    
    # protected resource
    get '/protected' do
      env['warden'].authenticate!
      slim :protected
    end

    get '/register' do
      slim :register
    end
  
  end
end
