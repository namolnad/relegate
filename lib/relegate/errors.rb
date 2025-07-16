# frozen_string_literal: true

module Relegate
  class RelegateError < StandardError
  end

  # Raised by {Relegate::Model#archive!}
  class RecordNotArchived < RelegateError
    attr_reader :record

    def initialize(message = nil, record = nil)
      @record = record
      super(message)
    end
  end

  # Raised by {Relegate::Model#unarchive!}
  class RecordNotUnarchived < RelegateError
    attr_reader :record

    def initialize(message = nil, record = nil)
      @record = record
      super(message)
    end
  end
end