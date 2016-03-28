module Uniqueness
  module Model #:nodoc:
    def self.included(base)
      base.extend ClassMethods
      base.class_attribute :uniqueness
    end

    module ClassMethods #:nodoc:
      # Adds random field support to Rails models
      #
      # Examples:
      #   To auto-generate a new random string for field +foo+
      #   has_random_field :foo
      #
      #   You can customize the generated string by
      #   passing an options hash. The following keys are supported:
      #
      #   +:length+ number of characters, defaults to <tt>32</tt>
      #
      #   +:type+ type of string, defaults to <tt>:hash</tt>
      #           can be one of: <tt>:human</tt>, <tt>:hash</tt>
      #
      #   +:blacklist+ characters to exclude when generating the random string,
      #                 defaults to <tt>[]</tt>
      def has_unique_field(name, options = {})
        defaults = { length: 32, type: :auto, blacklist: [] }
        options.merge!(defaults)
        @uniqueness ||= []
        @uniqueness[name] = options
        include Uniqueness::Model::Extenstions
      end
    end

    module Extenstions #:nodoc:
      # validates :uniqueness_field_validatation

      # Custom validations for unique fields
      def uniqueness_field_validatation
        @uniqueness.each do |name, _options|
          errors.add(name, '') if send(name).nil?
        end
      end
    end
  end
end
