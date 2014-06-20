class Api::ApiController < ApiController
  skip_before_filter :api_session_token_authenticate!, only: [:index]

  def index
    respond_with \
      sessions_url: api_sessions_url,
      # chats_url:    api_chats_url,
      reports_url:  api_reports_url,
    #    equipment_url: api_equipment_url, 
      # messages_url: api_messages_url, 
      # tasks_url: api_tasks_url
  end
end
