# frozen_string_literal: true

require "test_helper"

class BelongsToRequiredByDefaultTest < Minitest::Test
  test "requires association" do
    ActiveRecord::Base.belongs_to_required_by_default = true

    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample do |t|
        t.belongs_to :user
      end
    end

    sql = "PRAGMA table_info(sample);"
    column = ActiveRecord::Base.connection.execute(sql).first

    assert_equal 1, column["notnull"]

    model_class = create_model { belongs_to :user }
    instance = model_class.create

    assert instance.errors[:user].any?
  end

  test "ignores association requirement" do
    ActiveRecord::Base.belongs_to_required_by_default = false

    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample do |t|
        t.belongs_to :user
      end
    end

    sql = "PRAGMA table_info(sample);"
    column = ActiveRecord::Base.connection.execute(sql).first

    assert_equal 1, column["notnull"]

    model_class = create_model { belongs_to :user }
    instance = model_class.create

    assert_empty instance.errors[:user]
  end

  test "respects given option" do
    ActiveRecord::Base.belongs_to_required_by_default = true

    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample do |t|
        t.belongs_to :user, null: true
      end
    end

    sql = "PRAGMA table_info(sample);"
    column = ActiveRecord::Base.connection.execute(sql).first

    assert_equal 1, column["notnull"]
  end
end
