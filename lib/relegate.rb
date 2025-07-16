# frozen_string_literal: true

require "active_support"

require_relative "relegate/configuration"
require_relative "relegate/errors"
require_relative "relegate/model"
require_relative "relegate/version"

module Relegate # rubocop:disable Style/Documentation
  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  ActiveSupport.on_load(:active_record) do
    include Relegate::Model
  end
end