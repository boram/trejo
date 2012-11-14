require 'trejo/view_helpers'

module Trejo
  class Railtie < Rails::Railtie
    initializer 'trejo.view_helpers' do
    ActionView::Base.send :include, ViewHelpers
  end
end
