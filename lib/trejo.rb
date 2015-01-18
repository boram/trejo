require 'trejo/version'
require 'trejo/railtie' if defined?(Rails)

module Trejo
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end

  class Configuration
    attr_accessor :site_title, :company_name

    def initialize
      @site_title = ''
      @company_name = ''
    end
  end
end