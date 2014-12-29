module Admin
  class FeedbacksController < BaseController
    before_action :set_feedback, only: [:show, :edit, :update, :destroy]

    def index
      @feedbacks = Feedback.all
    end

    def show
    end

    def new
      @feedback = Feedback.new
    end

    def edit
    end

    def create
      @feedback = Feedback.new(feedback_params)

      respond_to do |format|
        if @feedback.save
          format.html { redirect_to [:admin, @feedback], notice: 'Feedback was successfully created.' }
          format.json { render action: 'show', status: :created, location: @feedback }
        else
          format.html { render action: 'new' }
          format.json { render json: @feedback.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @feedback.update(feedback_params)
          format.html { redirect_to [:admin, @feedback], notice: 'Feedback was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @feedback.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @feedback.destroy
      respond_to do |format|
        format.html { redirect_to admin_feedbacks_url }
        format.json { head :no_content }
      end
    end

    private
      def set_feedback
        @feedback = Feedback.find(params[:id])
      end

      def feedback_params
        params.require(:feedback).permit(:partner_id, :subject, :name, :email, :msg)
      end
  end
end