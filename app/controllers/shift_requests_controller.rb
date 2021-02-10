class ShiftRequestsController < ApplicationController

  def index
    if staff_user_signed_in?
      @shift_requests = current_staff_user.shift_requests
      @shifts = current_staff_user.shifts
      @shift_request = ShiftRequest.new
    end
  end

  def create
    @shift_request = ShiftRequest.new(shift_request_params)
    if @shift_request.valid?
      @shift_request.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def search
    @search_params = search_params
  end

  def submit_confirm
    @search_params = search_params
    if @search_params[:board_id].present? && @search_params[:start_term].present? && @search_params[:end_term].present?
      @shift_requests = ShiftRequest.search(@search_params).includes(:board, :staff_user)
    else
      render :search
    end
  end

  private

  def shift_request_params
    params.require(:shift_request).permit(:start_time, :end_time, :board_id).merge(staff_user_id: current_staff_user.id)
  end

  def search_params
    params.fetch(:search, {}).permit(:board_id, :start_term, :end_term).merge(staff_user_id: current_staff_user.id)
  end
end
