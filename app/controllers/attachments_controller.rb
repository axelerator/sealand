
class AttachmentsController < ApplicationController

  # POST /attachments
  # POST /attachments.json
  def create
    @plan = Plan.find(params[:plan_id])
    @plan.attachments.create(params[:attachment]);
    redirect_to plan_path(@plan)
  end

  def destroy
    @plan = Plan.find(params[:plan_id])
    @attachment = @plan.attachments.find(params[:id])
    @attachment.destroy
    redirect_to plan_path(@plan)
  end
 
end