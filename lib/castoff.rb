# frozen_string_literal: true

require "active_support"

require_relative "castoff/configuration"
require_relative "castoff/errors"
require_relative "castoff/model"
require_relative "castoff/version"

module Castoff # rubocop:disable Style/Documentation
  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  ActiveSupport.on_load(:active_record) do
    include Castoff::Model
  end
end
