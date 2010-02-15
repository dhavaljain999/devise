module Validatable
  class ValidatesUniquenessOf < Validatable::ValidationBase
    def scope
      if @scope == []
        nil
      else
        @scope
      end
    end

    def message(instance)
      "has already been taken"
    end
  end

  class ValidatesLengthOf < ValidationBase
    def message(instance)

      unless within.nil?
        maximum = within.max
      end
      unless !maximum.nil? && instance.send(self.attribute).length <= maximum
        "is too long (maximum is 20 characters)"
      else
        "is too short (minimum is 6 characters)"
      end
    end
  end
end

module Devise
  module Orm
    module Mongoid

      module InstanceMethods
        def reload
          super
          self
        end
      end

      def self.included_modules_hook(klass)
        klass.send :extend,  self
        # TODO: it's a little hack. Patch pull on master
        klass.send :include, InstanceMethods
        klass.send :include, ::Mongoid::Timestamps
        yield

        klass.devise_modules.each do |mod|
          klass.send(mod) if klass.respond_to?(mod)
        end

      end

      include Devise::Schema

      # Tell how to apply schema methods. This automatically converts DateTime
      # to Time, since MongoMapper does not recognize the former.
      def apply_schema(name, type, options={})
        return unless Devise.apply_schema
        type = Time if type == DateTime
        field name, {:type => type}.merge(options)
      end
    end
  end
end

Mongoid::Document::ClassMethods.send(:include, Devise::Models)
