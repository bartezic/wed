module App
  class FeedbacksController < BaseController
    def create
      @feedback = Feedback.new(feedback_params)
      @feedback.save
      FeedbackMailer.new_feedback(@feedback).deliver
      respond_to do |format|
        format.js { render :layout => false }
      end
    end

    private
      def feedback_params
        params.require(:feedback).permit(:partner_id, :subject, :name, :email, :msg)
      end
  end
end
