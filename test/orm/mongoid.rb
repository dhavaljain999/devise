require 'mongoid'
Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db('devise-test-suite')
end
require File.join(File.dirname(__FILE__), '..', 'rails_app', 'config', 'environment')
require 'test_help'

module Mongoid::Document
  # TODO This should not be required
  def invalid?
    !valid?
  end
end

class ActiveSupport::TestCase
  setup do
    Mongoid.database.collections.each do |coll|
      coll.remove
    end
  end
end

