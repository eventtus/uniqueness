module Uniqueness
  class Engine < Rails::Engine # :nodoc:
    ActiveSupport.on_load(:active_record) do
      ActiveRecord::Base.send(:include, Uniqueness::Model)
    end
  end
end
