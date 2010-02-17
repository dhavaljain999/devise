class User
  include Mongoid::Document
  field :created_at, :type => DateTime
  devise :authenticatable, :confirmable, :lockable, :recoverable,
         :registerable, :rememberable, :timeoutable, :token_authenticatable,
         :trackable, :validatable
  # attr_accessible :username, :email, :password, :password_confirmation
end
