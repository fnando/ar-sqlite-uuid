# frozen_string_literal: true

ActiveSupport.on_load(:active_record) do
  require "active_record/connection_adapters/sqlite3_adapter"

  ActiveRecord::Migration::Current.include(AR::UUID::Schema)

  ActiveRecord::ConnectionAdapters::SQLite3::TableDefinition.include(
    AR::UUID::TableDefinition
  )
end
