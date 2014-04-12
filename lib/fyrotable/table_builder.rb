module Fyrotable
  class TableBuilder
    attr_accessor :table

    def initialize(name, options = {})

      self.table = Table.new(options)
      table.name = name
    end

    def column(name, options = {}, &block)
      table.columns << Column.new(name, options, block)
    end

    def build
      table
    end
  end
end
