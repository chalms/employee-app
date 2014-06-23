module AppHelper
  
  def body_classes
    [controller_name,
      "#{controller_name}-#{action_name}"
    ].join(" ").gsub("_", "-")
  end

  def inside_layout(layout = 'application', &block)
    render :inline => capture_haml(&block), :layout => "layouts/#{layout}"
  end

  def users_homepage_url
    home_url
  end

  def users_homepage_path
    home_path
  end

  def csrf_meta_tag
    if protect_against_forgery?
      out = %(<meta name="csrf-param" content="%s"/>\n)
      out << %(<meta name="csrf-token" content="%s"/>)
      out % [ Rack::Utils.escape_html(request_forgery_protection_token),
              Rack::Utils.escape_html(form_authenticity_token) ]
    end
  end

end