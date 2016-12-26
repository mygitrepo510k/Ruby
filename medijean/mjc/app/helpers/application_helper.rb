module ApplicationHelper

  def logo_path
    if Rails.env.production?
      "logo-production.png"
    elsif Rails.env.bvt?
      "logo-bvt.png"
    else
      "logo.png"
    end
  end

  # @param [String] str string in a form of nnn-nnn-nnn
  # @return [Array] array of strings or empty array
  def splitted_phone(str)
    str.is_a?(String) ? str.split('-') : []
  end
  
  def markdown(text)
    render = Redcarpet::Render::HTML.new({:filter_html=>true, :hard_warp=>true})
    markdown = Redcarpet::Markdown.new( render, :autolink=> true, :space_after_headers => true)
    markdown.render(text).html_safe
  end

  # @param [Notification] object
  # @return string
  def render_notification(notification)
    string = I18n.t(:"notifications.#{notification.notification_type}") 
    result = string.gsub(/({(.*?)})/) do |match|
        parameter_name = match.slice(1, match.length - 2)
        notification.parameters[parameter_name.to_sym]
    end
  end

  def errors_for(model, attribute)
    if model.errors[attribute].present?
      content_tag :span, :class => 'field_with_errors' do
        model.errors[attribute].join(", ")
      end
    end
  end
end
