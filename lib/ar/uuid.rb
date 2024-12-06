# frozen_string_literal: true

module AR
  module UUID
    require "active_record"
    require "active_record/base"
    require "ar/uuid/version"
    require "ar/uuid/schema"
    require "ar/uuid/table_definition"
    require "ar/uuid/ext"

    class << self
      attr_accessor :default_function
    end

    def self.default_function_with_prefix(prefix)
      if prefix && default_function.include?("%{prefix}")
        format(default_function, prefix:)
      else
        default_function
      end
    end
  end
end
