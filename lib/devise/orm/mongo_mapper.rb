module Devise
  module Orm
    module MongoMapper
      def authenticatable
        key :email, String
        key :encrypted_password, String
        key :password_salt, String
      end

      def confirmable
        key :confirmation_token, String
        key :confirmed_at, DateTime
        key :confirmation_sent_at, DateTime
      end

      def recoverable
        key :reset_password_token, String
      end

      def rememberable
        key :remember_token, String
        key :remember_created_at, DateTime
      end
    end
  end
end
