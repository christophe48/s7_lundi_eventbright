module AttendancesHelper
  def attendances_include?(event,attendances)
    attendances.find_by(user: current_user.id, event: event.id) == nil
  end
end
