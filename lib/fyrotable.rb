require "debugger"
require "fyrotable/version"
require "fyrotable/table_builder"
require "fyrotable/table"
require "fyrotable/column"
require "fyrotable/railtie" if defined?(Rails)

module Fyrotable
  class << self
    attr_accessor :registered_tables, :load_paths

    def setup
      self.load_paths = []
      yield self
      self.initialize
    end

    def initialize
      self.load_paths << File.expand_path('app/tables', Rails.root)
      self.load_paths.each do |load_path|
        files = Dir["#{load_path}/**/*.rb"]
        files.each{ |file| load file }
      end

      Railtie.setup
    end

    def register(name, options = {}, &block)
      builder = TableBuilder.new(name, options)
      builder.instance_eval(&block)

      self.registered_tables = {} if self.registered_tables.nil?
      self.registered_tables[name] = builder.build
    end
  end
end
