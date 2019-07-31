# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def new_course(user, course)
    @course = course
    mail(to:      user.email,
         subject: 'New course!')
  end
end
