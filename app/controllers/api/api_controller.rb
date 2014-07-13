class Api::ApiController < ApiController
  skip_before_filter :api_session_token_authenticate!, only: [:index]

  def index
    respond_with \
      users_url: api_users_url,
      sessions_url: api_sessions_url,
      reports_url:  api_reports_url,
      employee_logs_url: api_employee_logs_url
  end
end
