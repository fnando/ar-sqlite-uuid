# frozen_string_literal: true

module AR
  module UUID
    module TableDefinition
      def self.included(base)
        base.class_eval do
          def references(*args, **options)
            super(*args, **options, type: options.fetch(:type, :text))
          end

          def belongs_to(*, **)
            references(*, **)
          end
        end
      end

      def primary_key(name, type = :primary_key, **options)
        prefix = options.delete(:prefix) || @name

        options[:default] ||= proc do
          ::AR::UUID.default_function_with_prefix(prefix)
        end

        type = :text if type == :primary_key

        super
      end
    end
  end
end
