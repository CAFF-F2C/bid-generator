class Buyers::RfpsController < Buyers::ApplicationController
  after_action :verify_authorized, except: [:new, :create]

  def new
    @rfp = current_buyer.rfps.build(start_year: Time.current.year)
  end

  def create
    @rfp = current_buyer.rfps.build(rfp_params)
    respond_to do |format|
      if @rfp.save
        if params.key?(:draft)
          format.any do
            flash[:success] = 'New RFP was created.'
            redirect_to edit_buyers_rfp_path(@rfp), status: :see_other
          end
        else
          format.any do
            flash[:success] = 'RFP was successfully updated.'
            redirect_to buyers_rfp_scores_path(@rfp), status: :see_other
          end
        end
      else
        flash[:alert] = 'RFP could not be saved.'
        format.html { render :new }
        format.turbo_stream { render :create }
      end
    end
  end

  def show
    @rfp = Rfp.find(params[:id])
    authorize(@rfp)
    @rfp.complete?
  end

  def edit
    @rfp = Rfp.find(params[:id])
    authorize(@rfp)
  end

  def update
    @rfp = Rfp.find(params[:id])
    authorize(@rfp)
    @rfp.assign_attributes(rfp_params)
    respond_to do |format|
      if @rfp.save
        if params.key?(:draft)
          flash.now[:success] = 'RFP was successfully updated.'
          format.html { render :edit }
          format.turbo_stream { render :update }
        else
          format.any do
            flash[:success] = 'RFP was successfully updated.'
            redirect_to buyers_rfp_scores_path(@rfp), status: :see_other
          end
        end
      else
        flash.now[:alert] = 'RFP could not be saved.'
        format.html { render :edit }
        format.turbo_stream { render :update }
      end
    end
  end

  def destroy
    @rfp = Rfp.find(params[:id])
    authorize(@rfp)
    if @rfp.destroy
      flash[:notice] = 'RFP was deleted.'
    else
      flash[:alert] = 'RFP could not be deleted.'
    end
    redirect_to buyers_documents_path
  end

  private

  def rfp_params
    params.require(:rfp).permit(:procurement_type_id, :start_year)
  end
end
