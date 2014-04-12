module Fyrotable
  class Application
    attr_accessor :registered_tables, :load_paths

    def initialize
      self.load_paths = []
      self.load_paths << File.expand_path('app/tables', Rails.root)
    end

    def setup
      attach_reloader
      load_tables!
    end

    def register(name, options = {}, &block)
      builder = TableBuilder.new(name, options)
      builder.instance_eval(&block)

      self.registered_tables = {} if registered_tables.nil?
      registered_tables[name] = builder.build
    end

    def attach_reloader
      self.load_paths.each do |load_path|
        Fyrotable::Railtie.config.watchable_dirs[load_path] = [:rb]
      end

      Rails.application.config.after_initialize do
        ActionDispatch::Reloader.to_prepare do
          Fyrotable.application.load_tables!
        end
      end
    end

    def load_tables!
      self.load_paths.each do |load_path|
        files = Dir["#{load_path}/**/*.rb"]
        files.each{ |file| load file }
      end
    end
  end
end
