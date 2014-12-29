class FeedbackMailer < ActionMailer::Base
  default from: "noreply@wedcity.pro"

  def new_feedback(feedback)
    @feedback = feedback

    mail(
      to:      Manager.all.map(&:email).join(','),
      subject: 'Новий фідбек!'
    )
  end
end
