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
end
