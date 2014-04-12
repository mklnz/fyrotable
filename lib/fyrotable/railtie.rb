require 'fyrotable/view_helpers'

module Fyrotable
  class Railtie < Rails::Railtie
    initializer "fyrotable.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
