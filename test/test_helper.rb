# frozen_string_literal: true

require "simplecov"
SimpleCov.start do
  add_filter(%r{test/support})
end

require "bundler/setup"
require "ar-sqlite-uuid"

require "minitest/utils"
require "minitest/autorun"

Dir["#{__dir__}/support/**/*.rb"].each do |file|
  require file
end

module Minitest
  class Test
    setup do
      AR::UUID.default_function = "ulid()"
    end
  end
end
