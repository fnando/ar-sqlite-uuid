# frozen_string_literal: true

module Minitest
  class Test
    def assert_uuid_column(model_class, column_name)
      model_class.reset_column_information
      column = model_class.columns.find {|col| col.name == column_name.to_s }

      assert_equal "TEXT", column.sql_type
      assert_equal "ulid()", column.default_function
    end

    def assert_text_column(model_class, column_name)
      model_class.reset_column_information
      column = model_class.columns.find {|col| col.name == column_name.to_s }

      assert_equal "TEXT", column.sql_type
    end

    def assert_integer_column(model_class, column_name)
      model_class.reset_column_information
      column = model_class.columns.find {|col| col.name == column_name.to_s }

      assert_equal "INTEGER", column.sql_type
    end
  end
end
