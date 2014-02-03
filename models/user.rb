# User class 
class User
  include DataMapper::Resource
  include BCrypt

  # hooks
  before :save, :generate_token
  before :create, :generate_token

  # properties
  property :id             ,Serial
  property :username       ,String         ,length: 0..50
  property :name           ,String         ,length: 0..200
  property :country        ,String         ,length: 0..30
  property :state          ,String         ,length: 0..50
  property :password       ,BCryptHash
  property :token          ,String         ,length: 0..100
  property :created        ,DateTime
  property :updated        ,DateTime
  property :active         ,Integer        ,default: 0

  # methods
  def generate_token
    # generate token
    self.token = BCrypt::Engine.generate_salt if self.token.nil?
  end

  def authorized? pass
    self.pass == pass
  end

end
