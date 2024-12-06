# frozen_string_literal: true

module AR
  module UUID
    module TableDefinition
      def references(*args, **options)
        binding.irb

        options[:type] = :text unless options.include?(:type)

        unless options.include?(:null)
          options[:null] =
            !ActiveRecord::Base.belongs_to_required_by_default
        end

        super
      end
      alias belongs_to references

      def primary_key(name, type = :primary_key, **options)
        options[:default] = -> { ::AR::UUID.default_function }
        super
      end
    end
  end
end
