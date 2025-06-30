# frozen_string_literal: true

module Castoff
  class CastoffError < StandardError
  end

  # Raised by {Castoff::Model#archive!}
  class RecordNotArchived < CastoffError
    attr_reader :record

    def initialize(message = nil, record = nil)
      @record = record
      super(message)
    end
  end

  # Raised by {Castoff::Model#unarchive!}
  class RecordNotUnUnarchived < CastoffError
    attr_reader :record

    def initialize(message = nil, record = nil)
      @record = record
      super(message)
    end
  end
end
