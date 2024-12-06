# frozen_string_literal: true

require "test_helper"

class ColumnTypeSpecifiedTest < Minitest::Test
  test "creates primary key as integer column" do
    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample, id: :integer do |t|
        t.text :name
      end
    end

    model_class = create_model

    assert_column_type model_class, :id, "INTEGER"
  end

  test "creates reference as integer column" do
    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample do |t|
        t.references :user, type: :integer
      end
    end

    model_class = create_model { has_many :users }

    assert_column_type model_class, :user_id, "INTEGER"
  end

  test "creates reference as integer column (belongs_to)" do
    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample do |t|
        t.belongs_to :user, type: :integer
      end
    end

    model_class = create_model { has_many :users }

    assert_column_type model_class, :user_id, "INTEGER"
  end

  test "creates reference as integer column (add_reference)" do
    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample do |t|
        t.text :name
      end
      add_reference :sample, :user, type: :integer
    end

    model_class = create_model

    assert_column_type model_class, :user_id, "INTEGER"
  end
end
