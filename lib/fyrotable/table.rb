module Fyrotable
  class Table
    attr_accessor :name, :columns, :options

    def initialize(options)
      self.columns = []
      self.options = options
    end

    def visible_columns
      columns = []
      @columns.each do |column|
        if column.options[:except].present?
          next if self.options[column.options[:except]]
        end

        columns << column
      end
      columns
    end

  end
end
