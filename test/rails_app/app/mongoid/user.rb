class User
  include Mongoid::Document
  field :created_at, :type => DateTime
  devise :authenticatable, :confirmable, :recoverable, :rememberable, :trackable,
         :validatable, :timeoutable, :lockable, :token_authenticatable
  # attr_accessible :username, :email, :password, :password_confirmation
end
