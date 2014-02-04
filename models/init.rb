# database requires
require "data_mapper"
require "bcrypt"

# database url
url = "sqlite://#{Dir.pwd}/db/authentication.db"
DataMapper.setup :default, url

# require models
require_relative "user"
#require_relative "profile"

# finalize
DataMapper.finalize
DataMapper.auto_upgrade!

# Data Generation
if User.count == 0 
  @user = User.create(username: "admin")
  @user.password = "admin"
  @user.save
end



