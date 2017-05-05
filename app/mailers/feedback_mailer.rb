class FeedbackMailer < ActionMailer::Base
  default from: "notifier@wedcity.pro"

  def new_feedback(feedback)
    @feedback = feedback

    mail(
      to:      Manager.all.map(&:email).join(','),
      subject: 'Новий фідбек!'
    )
  end
end
