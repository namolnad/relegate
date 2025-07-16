# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "relegate"

require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"
require "active_record"

ActiveRecord::Base.logger = Logger.new(ENV["VERBOSE"] ? $stdout : nil)
ActiveRecord::Migration.verbose = ENV["VERBOSE"]

# migrations
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Schema.define do
  create_table :users do |t|
    t.datetime :archived_at
    t.datetime :discarded_at
  end
end

class User < ActiveRecord::Base
  castoff
  castoff column_name: :discarded_at
end
