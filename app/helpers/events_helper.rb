module EventsHelper
  def compare(user_id,session_id)
    return user_id == session_id
  end
end
