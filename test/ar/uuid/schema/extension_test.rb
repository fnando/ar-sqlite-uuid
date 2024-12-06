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
    record = model_class.create!

    assert_default_function model_class, :id, "uuid()"
    assert_column_type model_class, :id, "TEXT"
    assert_match(/^.{8}-.{4}-4.{3}-.{4}-.{12}$/, record.id)
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
    record = model_class.create!

    assert_default_function model_class, :id, "ulid()"
    assert_column_type model_class, :id, "TEXT"
    assert_match(/^.{26}$/, record.id)
  end

  test "uses ulid with prefix (static)" do
    AR::UUID.default_function = "ulid_with_prefix('test')"

    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample do |t|
        t.text :name
      end
    end

    model_class = create_model
    record = model_class.create!

    assert_default_function model_class, :id, "ulid_with_prefix('test')"
    assert_column_type model_class, :id, "TEXT"
    assert_match(/^test_.{26}$/, record.id)
  end

  test "uses ulid with prefix (table)" do
    AR::UUID.default_function = "ulid_with_prefix('%{prefix}')"

    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample do |t|
        t.text :name
      end
    end

    model_class = create_model
    record = model_class.create!

    assert_default_function model_class, :id, "ulid_with_prefix('sample')"
    assert_column_type model_class, :id, "TEXT"
    assert_match(/^sample_.{26}$/, record.id)
  end

  test "uses ulid with prefix (create_table)" do
    AR::UUID.default_function = "ulid_with_prefix('%{prefix}')"

    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample, prefix: "internal" do |t|
        t.text :name
      end
    end

    model_class = create_model
    record = model_class.create!

    assert_default_function model_class, :id, "ulid_with_prefix('internal')"
    assert_column_type model_class, :id, "TEXT"
    assert_match(/^internal_.{26}$/, record.id)
  end

  test "uses primary key directly" do
    AR::UUID.default_function = "ulid()"

    schema do
      drop_table :sample if data_source_exists?(:sample)
      create_table :sample, id: false do |t|
        t.primary_key :id
        t.text :name
      end
    end

    model_class = create_model
    record = model_class.create!

    assert_default_function model_class, :id, "ulid()"
    assert_column_type model_class, :id, "TEXT"
    assert_match(/^.{26}$/, record.id)
  end
end
