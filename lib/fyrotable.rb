require "fyrotable/version"
require "fyrotable/application"
require "fyrotable/table_builder"
require "fyrotable/table"
require "fyrotable/column"
require "fyrotable/railtie" if defined?(Rails)

module Fyrotable
  class << self
    attr_accessor :application

    def application
      @application ||= ::Fyrotable::Application.new
    end

    def setup
      yield application
      application.setup
    end

    delegate :register, to: :application
    delegate :registered_tables, to: :application
  end
end
