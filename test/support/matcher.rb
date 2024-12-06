# frozen_string_literal: true

module Minitest
  class Test
    def assert_default_function(model_class, column_name, func)
      model_class.reset_column_information
      column = model_class.columns.find {|col| col.name == column_name.to_s }

      assert_equal func, column.default_function
    end

    def assert_column_type(model_class, column_name, expected_type)
      model_class.reset_column_information
      column = model_class.columns.find {|col| col.name == column_name.to_s }

      assert_equal expected_type, column.sql_type
    end
  end
end
