module Fyrotable
  class Column    
    attr_accessor :name, :block, :options

    def initialize(name, options = {}, block)
      self.name = name
      self.options = options
      self.block = block
    end
  end
end
