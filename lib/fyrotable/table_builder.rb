module Fyrotable
  class TableBuilder
    attr_accessor :table

    def initialize(name, options = {})

      self.table = Table.new(options)
      self.table.name = name
    end

    def column(name, options = {}, &block)
      self.table.columns << Column.new(name, options, block)
    end

    def build
      self.table
    end
  end
end
