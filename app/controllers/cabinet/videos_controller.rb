module Cabinet
  class VideosController < BaseController
    # POST /videos
    # POST /videos.json
    def create
      @video = current_partner.videos.build(video_params)

      respond_to do |format|
        if @video.save
          format.html { redirect_to :back, notice: 'Video was successfully created.' }
          format.json { render json: { type: video, video: @video }, status: :ok }
        else
          format.html { render action: 'new' }
          format.json { render json: { type: video, errors: @video.errors} , status: :unprocessable_entity }
        end
      end
    end

    # DELETE /videos/1
    # DELETE /videos/1.json
    def destroy
      @video = current_partner.videos.find(params[:id])
      
      @video.destroy
      respond_to do |format|
        format.html { redirect_to :back }
        format.json { head :no_content }
      end
    end

    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def video_params
        params.require(:video).permit(:link)
      end

  end
end