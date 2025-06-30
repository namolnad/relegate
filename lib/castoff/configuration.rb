# frozen_string_literal: true

module Castoff
  class Configuration # rubocop:disable Style/Documentation
    attr_accessor :column_name
    attr_writer :marked_scope_name, :unmarked_scope_name, :mark_method_name, :unmark_method_name

    def initialize
      @column_name = :archived_at
    end

    def marked_scope_name
      @marked_scope_name || @column_name.to_s.sub(/_at\z/, "").to_sym
    end

    def unmarked_scope_name
      @unmarked_scope_name || :"un#{marked_scope_name}"
    end

    def mark_method_name
      @mark_method_name || verb.to_sym
    end

    def unmark_method_name
      @unmark_method_name || :"un#{verb}"
    end

    private

    def verb
      infer_verb_from_column(column_name)
    end

    def infer_verb_from_column(column)
      participle = column.to_s.sub(/_at\z/, "")
      verb_from_participle(participle)
    end

    def verb_from_participle(word)
      if word.end_with?("ved") || word.end_with?("ted")
        # Likely no "e" needed, e.g., "loved" => "love", "created" => "create", "archived" => "archive"
        word.to_s.sub(/ed\z/, "e")
      else
        # "discarded" => "discard"
        word.to_s.sub(/ed\z/, "")
      end
    end
  end
end
