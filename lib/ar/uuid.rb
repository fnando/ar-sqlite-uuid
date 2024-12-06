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
  end
end
