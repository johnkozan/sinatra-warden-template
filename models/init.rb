# database requires
require "data_mapper"
#require "dm-core"
#require "dm-migrations"
require "bcrypt"



# database url
url = "sqlite://#{Dir.pwd}/db/castivo_sms_campaing.db"
DataMapper.setup :default, url


# require models
require_relative "user"
#require_relative "profile"


# finalize
DataMapper.finalize
DataMapper.auto_upgrade!


