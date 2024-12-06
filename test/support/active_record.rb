# frozen_string_literal: true

require "active_record"

ActiveRecord::Base.establish_connection "sqlite3::memory:"
ActiveRecord::Base.connection.execute "select 1"
conn = ActiveRecord::Base.connection.instance_variable_get(:@raw_connection)
conn.enable_load_extension(true)
Dir[".sqlpkg/**/*.{dylib,so}"].each {|path| conn.load_extension(path) }
conn.enable_load_extension(false)
ActiveRecord::Migration.verbose = false
ActiveRecord::Base.logger = nil

# Apply a migration directly from your tests:
#
#   test "do something" do
#     schema do
#       drop_table :users if table_exists?(:users)
#
#       create_table :users do |t|
#         t.text :name, null: false
#       end
#     end
#   end
#
def schema(&)
  ActiveRecord::Schema.define(version: 0, &)
end

# Create a new migration, which can be executed up and down.
#
#   test "do something" do
#     migration = with_migration do
#       def up
#         # do something
#       end
#
#       def down
#         # undo something
#       end
#     end
#
#     migration.up
#     migration.down
#   end
#
def with_migration(&)
  migration_class = ActiveRecord::Migration[
    ActiveRecord::Migration.current_version
  ]

  Class.new(migration_class, &).new
end
