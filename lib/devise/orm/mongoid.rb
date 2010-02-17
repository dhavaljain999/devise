module Validatable
  class ValidatesUniquenessOf < Validatable::ValidationBase
    # with devise, we need scope.
    # This little hack no usefull with activeModel and Rails 3.
    # So delete it with devise 1.1
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
