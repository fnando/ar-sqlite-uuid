# frozen_string_literal: true

module AR
  module UUID
    module Schema
      def create_table(table_name, **options, &block)
        override_id = !options.key?(:id)
        options[:id] = false if override_id

        super(table_name, **options) do |t|
          if override_id
            t.primary_key :id,
                          :text,
                          default: AR::UUID.default_function
          end

          instance_exec(t, &block)
        end
      end

      def add_reference(table_name, ref_name, **options)
        options[:type] ||= "text"

        super
      end
    end
  end
end
