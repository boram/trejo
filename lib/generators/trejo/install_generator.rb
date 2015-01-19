module Trejo
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)
      desc 'Creates Trejo initializer for your application'

      def copy_initializer
        template 'initializer.rb', 'config/initializers/trejo.rb'
      end
    end
  end
end