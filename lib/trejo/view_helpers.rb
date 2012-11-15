module Trejo
  module ViewHelpers
    def nav_item name, url, options={}
      current_path = request.fullpath

      selected = if options[:selected]
        current_path =~ options[:selected]
      elsif options[:root_path]
        if options[:ignore_params]
          current_path =~ /^#{Regexp.escape(url)}\/.*\?/
        else
          current_path =~ /^#{Regexp.escape(url)}\/.*/
        end
      else
        if options[:ignore_params]
          current_path =~ /^#{Regexp.escape(url)}\?.*/
        else
          current_path == url
        end
      end

      link_class = 'active' if selected
      link_to name, url, class: link_class
    end
  end
end
