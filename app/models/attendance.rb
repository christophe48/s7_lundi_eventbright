class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  after_create :participation_confirmation

  def participation_confirmation
    AttendanceMailer.participate_mail(self.event.administrator,self.user, self.event).deliver_now
  end



end
