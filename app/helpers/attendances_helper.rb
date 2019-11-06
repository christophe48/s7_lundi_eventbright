module AttendancesHelper
  def attendances_include?
    current_user.id == attendances.user_id && @event.id == attendances.event_id
  end
end
