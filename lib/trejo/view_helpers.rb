module Trejo
  module ViewHelpers
    def nav_item name, url, options={}
      current_path = request.fullpath

      selected = if options[:selected]
        current_path =~ options[:selected]
      else
        current_path =~ /^#{Regexp.escape(url)}.*(?:\?.*)?/
      end

      link_class = options[:class] || 'active' if selected
      link_to name, url, class: link_class
    end

    def merge_classes(*classes)
      classes.flatten
        .reject(&:blank?).map(&:split)
        .flatten.uniq.join ' '
    end

    def title page_title
      return if page_title.blank?
      content_for(:title) { "#{page_title} | #{Trejo.configuration.site_title}" }
    end

    def body_id
      if content_for?(:page_id)
        content_for(:page_id)
      else
        "#{controller.controller_name}-#{controller.action_name}-page".dasherize
      end
    end

    def body_class
      content_for?(:page_class) ? content_for(:page_class) : nil
    end

    def page_id value
      content_for(:page_id) { value }
    end

    def page_class value
      content_for(:page_class) { value }
    end

    def copyright_notice
      "\u00A9 #{Date.current.year} #{Trejo.configuration.company_name}, All Rights Reserved"
    end
  end
end
