module Uniqueness
  module Model # :nodoc:
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
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
      #   +:case_sensitive+ defaults to <tt>true</tt>
      #
      #   +:type+ type of string, defaults to <tt>:hash</tt>
      #           can be one of: <tt>:human</tt>, <tt>:hash</tt>
      #
      #   +:blacklist+ characters to exclude when generating the random string,
      #                 defaults to <tt>[]</tt>
      def has_unique_field(name, options = {})
        validates name, presence: true, uniqueness: true
        before_validation do
          value = self.send(name)
          self.send("#{name}=", uniqueness_generate(options)) unless value
        end
      end
    end

    # Generates a new code based on given options
    def uniqueness_generate(opts = {})
      options = { length: 32, type: :auto, blacklist: [] }
      options.merge!(opts)
      dict = uniqueness_dictionary - options[:blacklist]
      dict = dict - [*(:A..:Z)].map(&:to_s) unless options[:case_sensitive]
      dict = dict - uniqueness_ambigious_dictionary if options[:type].to_sym == :human
      Array.new(options[:length]).map { dict[rand(dict.length)] }.join
    end

    # Dictionary used for uniqueness generation
    def uniqueness_dictionary
      [*(:A..:Z), *(:a..:z), *(0..9)].map(&:to_s)
    end

    def uniqueness_ambigious_dictionary
      [1, 5, 8, :B, :o, :O, :I, :l, :L, :s, :S, :u, :U].map(&:to_s)
    end
  end
end
