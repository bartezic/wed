module Admin
  class ManagersController < BaseController
    before_action :set_manager, only: [:show, :edit, :update, :destroy]

    # GET /manager_users
    # GET /manager_users.json
    def index
      @managers = Manager.order(id: :desc).page(params[:page]).per(25)
    end

    # GET /manager_users/1
    # GET /manager_users/1.json
    def show
    end

    # GET /manager_users/new
    def new
      @manager = Manager.new
      @manager.user = User.new
    end

    # GET /manager_users/1/edit
    def edit
    end

    # POST /managers
    # POST /managers.json
    def create
      @manager = Manager.new(manager_params)

      respond_to do |format|
        if @manager.save
          format.html { redirect_to [:admin, @manager], notice: 'manager user was successfully created.' }
          format.json { render action: 'show', status: :created, location: @manager }
        else
          format.html { render action: 'new' }
          format.json { render json: @manager.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /managers/1
    # PATCH/PUT /managers/1.json
    def update
      respond_to do |format|
        if @manager.update(manager_params)
          format.html { redirect_to [:admin, @manager], notice: 'manager user was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @manager.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /managers/1
    # DELETE /managers/1.json
    def destroy
      @manager.destroy
      respond_to do |format|
        format.html { redirect_to admin_managers_url }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_manager
        @manager = Manager.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def manager_params
        params.require(:manager).permit(:name, user_attributes: [:id, :email, :avatar, :avatar_remote_url, :password, :password_confirmation])
      end
  end
end