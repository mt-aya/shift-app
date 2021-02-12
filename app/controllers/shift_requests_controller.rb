class ShiftRequestsController < ApplicationController
  before_action :visit_owner, except: [:index]
  before_action :visit_no_login_user, except: [:index]

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
    if @search_params[:board_id].present? && @search_params[:start_term].present? && @search_params[:end_term].present?
      @shift_requests = current_staff_user.shift_requests.search(@search_params).includes(:board, :staff_user).order(start_time: 'ASC')
      session[:search] = @shift_requests.ids
    else
      render :search
    end
  end

  def submit
    ids = session[:search]
    if ids.length != 0
      shift_requests = current_staff_user.shift_requests.where(id: ids).includes(:board, :staff_user)
      shift_requests.update(submitted: true)
      ids.clear
      redirect_to root_path
    else
      render :search
    end
  end

  private

  def shift_request_params
    params.require(:shift_request).permit(:start_time, :end_time, :board_id).merge(staff_user_id: current_staff_user.id, submitted: false)
  end

  def search_params
    params.fetch(:search, {}).permit(:board_id, :start_term, :end_term).merge(staff_user_id: current_staff_user.id)
  end

  def visit_owner
    redirect_to root_path if owner_signed_in?
  end

  def visit_no_login_user
    redirect_to root_path unless owner_signed_in? || staff_user_signed_in?
  end
end
