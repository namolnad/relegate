# frozen_string_literal: true

require "active_support/concern"

module Relegate
  module Model # rubocop:disable Style/Documentation
    extend ActiveSupport::Concern

    class_methods do # rubocop:disable Metrics/BlockLength
      def castoff(column_name: nil) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
        config = Relegate.configuration.dup.tap do |c|
          c.column_name = column_name if column_name
        end

        class_eval <<-CODE, __FILE__, __LINE__ + 1
          def #{config.marked_scope_name}?
            self[#{config.column_name.inspect}].present?
          end

          def #{config.unmarked_scope_name}?
            !#{config.marked_scope_name}?
          end

          def #{config.mark_method_name}
            return false if #{config.marked_scope_name}?
            run_callbacks(:#{config.mark_method_name}) do
              update_attribute(#{config.column_name.inspect}, Time.current)
            end
          end

          def #{config.unmark_method_name}
            return false unless #{config.marked_scope_name}?
            run_callbacks(:#{config.unmark_method_name}) do
              update_attribute(#{config.column_name.inspect}, nil)
            end
          end

          def #{config.mark_method_name}!
            #{config.mark_method_name} || _raise_record_not_archived
          end

          def #{config.unmark_method_name}!
            #{config.unmark_method_name} || _raise_record_not_unarchived
          end

          private

          def _raise_record_not_#{config.marked_scope_name}
            raise ::Relegate::RecordNotArchived.new(archived_fail_message, self)
          end

          def _raise_record_not_#{config.unmarked_scope_name}
            raise ::Relegate::RecordNotUnarchived.new(unarchived_fail_message, self)
          end

          def #{config.marked_scope_name}_fail_message
            return "A #{config.marked_scope_name} record cannot be #{config.marked_scope_name}" if #{config.marked_scope_name}?

            "Failed to #{config.mark_method_name} the record"
          end

          def #{config.unmarked_scope_name}_fail_message
            return "An #{config.unmarked_scope_name} record cannot be #{config.unmarked_scope_name}" if #{config.unmark_method_name}?

            "Failed to #{config.unmark_method_name} the record"
          end

          class << self
            def #{config.mark_method_name}_all
              #{config.marked_scope_name}.each(&:#{config.mark_method_name})
            end
            def #{config.mark_method_name}_all!
              #{config.marked_scope_name}.each(&:#{config.mark_method_name}!)
            end
            def #{config.unmark_method_name}_all
              #{config.unmarked_scope_name}.each(&:#{config.unmark_method_name})
            end
            def #{config.unmark_method_name}_all!
              #{config.unmarked_scope_name}.each(&:#{config.unmark_method_name}!)
            end
          end
        CODE

        scope config.marked_scope_name, -> { where.not(config.column_name => nil) }
        scope config.unmarked_scope_name, -> { where(config.column_name => nil) }
        scope :"with_#{config.marked_scope_name}", -> { unscope(where: config.column_name) }

        define_model_callbacks config.mark_method_name
        define_model_callbacks config.unmark_method_name
      end
    end
  end
end