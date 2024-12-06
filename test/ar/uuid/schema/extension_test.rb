# frozen_string_literal: true

require "test_helper"

class ExtensionTest < Minitest::Test
  test "uses uuid" do
    AR::UUID.default_function = "uuid()"
    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample do |t|
        t.text :name
      end
    end

    model_class = create_model

    assert_equal "uuid()",
                 model_class.columns_hash["id"].default_function
  end

  test "uses ulid" do
    AR::UUID.default_function = "ulid()"

    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample do |t|
        t.text :name
      end
    end

    model_class = create_model

    assert_equal "ulid()",
                 model_class.columns_hash["id"].default_function
  end
end
