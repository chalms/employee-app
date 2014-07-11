module AppHelper
  def error!(e, origin)
    origin ||= :sign_up
    flash[:error] = e
    render :action => origin
  end

end