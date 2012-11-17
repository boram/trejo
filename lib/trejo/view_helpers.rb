module Trejo
  module ViewHelpers
    def nav_item name, url, options={}
      current_path = request.fullpath

      selected = if options[:selected]
        current_path =~ options[:selected]
      else
        current_path =~ /^#{Regexp.escape(url)}.*(?:\?.*)?/
      end

      link_class = 'active' if selected
      link_to name, url, class: link_class
    end
  end
end
