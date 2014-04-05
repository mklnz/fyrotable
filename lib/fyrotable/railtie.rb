require 'fyrotable/view_helpers'

module Fyrotable
  class Railtie < Rails::Railtie
    initializer "fyrotable.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end

    def self.setup
      Fyrotable.load_paths.each do |load_path|
        config.watchable_dirs[load_path] = [:rb]
      end
    end
  end
end
