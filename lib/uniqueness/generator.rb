require 'securerandom'

module Uniqueness
  class << self
    def generate(opts = {})
      options ||= {}
      options = uniqueness_default_options.merge(opts)
      dict = uniqueness_dictionary - options[:blacklist]
      dict -= [*(:A..:Z)].map(&:to_s) unless options[:case_sensitive]
      dict -= uniqueness_ambigious_dictionary if options[:type].to_sym == :human
      dict = uniqueness_numbers_dictionary if options[:type].to_sym == :numbers
      code = Array.new(options[:length]).map { dict[SecureRandom.random_number(dict.length)] }.join
      "#{options[:prefix]}#{code}#{options[:suffix]}"
    end

    # Dictionary used for uniqueness generation
    def uniqueness_dictionary
      [*(:A..:Z), *(:a..:z), *(0..9)].map(&:to_s)
    end

    def uniqueness_ambigious_dictionary
      [:b, :B, :o, :O, :q, :i, :I, :l, :L, :s, :S, :u, :U, :z, :Z, :g, 1, 2, 9, 5].map(&:to_s)
    end

    def uniqueness_numbers_dictionary
      [*(0..9)].map(&:to_s)
    end

    # Default sorting options
    def uniqueness_default_options
      {
        length: 32,
        type: :auto,
        blacklist: [],
        scope: [],
        suffix: '',
        prefix: ''
      }
    end
  end
end
