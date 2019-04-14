module Uniqueness
  module Model # :nodoc:
    def self.included(base)
      base.extend ClassMethods
      # Track all uniqueness arguments
      base.class_attribute :uniqueness_options
    end

    module ClassMethods
      # Adds random field support to Rails models
      #
      # Examples:
      #   To auto-generate a new random string for field +foo+
      #   has_unique_field :foo
      #
      #   You can customize the generated string by
      #   passing an options hash. The following keys are supported:
      #
      #   +:trigger_on+ when to be generated, can be one of ActiveRecord callbacks (<tt>before_validation</tt>, <tt>before_create</tt>, <tt>before_save</tt>, <tt>after_initialize</tt>), default to <tt>:before_validation</tt>
      #   +:length+ number of characters, defaults to <tt>32</tt>
      #
      #   +:case_sensitive+ defaults to <tt>true</tt>
      #
      #   +:type+ type of string, defaults to <tt>:auto</tt>
      #           can be one of: <tt>:human</tt>, <tt>:auto</tt>
      #
      #   +:blacklist+ characters to exclude when generating the random
      #                string, defaults to <tt>[]</tt>
      #
      #   +:scope+ defines the `ActiveRecord` `scope` applied before
      #            calculating the `position` field value.
      #            defaults to <tt>[]</tt>
      def has_unique_field(name, options = {})
        self.uniqueness_options ||= {}
        self.uniqueness_options[name] = Uniqueness.uniqueness_default_options.merge(options)

        case options[:trigger_on]
        when :before_create
          before_create :uniqueness_generate
        when :before_save
          before_save :uniqueness_generate
        when :after_initialize
          after_initialize :uniqueness_generate
        else
          before_validation :uniqueness_generate
        end

        validate :uniqueness_validation
        define_method("regenerate_#{name}") { self.update("#{name}": Uniqueness.generate(self.uniqueness_options[name])) }
      end
    end

    # Generates a new code based on given options
    def uniqueness_generate
      self.uniqueness_options.each do |field, options|
        value = send(field)
        unless value.present?
          value = Uniqueness.generate(options)
          self.send("#{field}=", value)
        end
      end
    end

    def uniqueness_validation
      self.class.uniqueness_options.each do |field, options|
        next unless new_record? || self.changes.has_key?(field)
        value = send(field)
        if value.nil?
          errors.add(field, 'should not be empty')
        else
          conditions = {}
          options[:scope].each do |s|
            conditions[s] = send(s)
          end
          conditions[field] = value
          query = self.class.where(conditions)
          errors.add(field, 'should be unique') if query.any?
        end
      end
    end
  end
end
