module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      if authenticated_user_id
        self.current_user = User.find(authenticated_user_id)
      else
        reject_unauthorized_connection
      end
    end

    private

    def authenticated_user_id
      cookies.encrypted[Rails.application.config.session_options[:key]]&.[]("user_id")
    end
  end
end
