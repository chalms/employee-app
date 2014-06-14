class ApplicationController < ActionController::API
	include ActionController::MimeResponds
  include ActionController::Helpers
  include ActionController::Cookies
  include ActiveModel::Serialization

end
