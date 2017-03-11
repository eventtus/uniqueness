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
        self.uniqueness_options[name] = self.uniqueness_default_options.merge(options)
        before_validation :uniqueness_generate
        validate :uniqueness_validation
      end

      # Default sorting options
      def uniqueness_default_options
        {
          length: 32,
          type: :auto,
          blacklist: [],
          scope: []
        }
      end
    end

    # Generates a new code based on given options
    def uniqueness_generate
      self.uniqueness_options.each do |field, options|
        value = send(field)
        unless value.present?
          dict = uniqueness_dictionary - options[:blacklist]
          dict -= [*(:A..:Z)].map(&:to_s) unless options[:case_sensitive]
          dict -= uniqueness_ambigious_dictionary if options[:type].to_sym == :human
          value = Array.new(options[:length]).map { dict[rand(dict.length)] }.join
          self.send("#{field}=", value)
        end
      end
    end

    # Dictionary used for uniqueness generation
    def uniqueness_dictionary
      [*(:A..:Z), *(:a..:z), *(0..9)].map(&:to_s)
    end

    def uniqueness_ambigious_dictionary
      [:b, :B, :o, :O, :q, :i, :I, :l, :L, :s, :S, :u, :U, :z, :Z, :g, 1, 2, 9, 5].map(&:to_s)
    end

    def uniqueness_validation
      self.class.uniqueness_options.each do |field, options|
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
