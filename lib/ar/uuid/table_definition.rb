# frozen_string_literal: true

module AR
  module UUID
    module TableDefinition
      def self.included(base)
        base.class_eval do
          references = instance_method(:references)

          define_method :references do |*args, **options|
            options[:type] = :text unless options.include?(:type)

            return if options.include?(:null)

            options[:null] =
              !ActiveRecord::Base.belongs_to_required_by_default

            references.bind_call(self, *args, **options)
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
