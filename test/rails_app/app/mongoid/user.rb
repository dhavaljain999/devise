class User
  include Mongoid::Document
  field :created_at, :type => DateTime
  devise :authenticatable, :confirmable, :lockable, :recoverable,
         :registerable, :rememberable, :timeoutable, :token_authenticatable,
         :trackable, :validatable, :http_authenticatable
  # attr_accessible :username, :email, :password, :password_confirmation
end
