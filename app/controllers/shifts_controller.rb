class ShiftsController < ApplicationController
  before_action :except_owner
  before_action :correct_owner, only: [:index, :monthly, :weekly, :calendar, :create, :search, :share]
  before_action :header_set, only: [:index_set, :search, :share]
  before_action :index_set, only: [:index, :monthly, :weekly, :calendar, :create]


  def index
  end

  def monthly
  end

  def weekly
  end

  def calendar
  end

  def create
    @board = Board.find(params[:board_id])
    @shift = Shift.new(shift_params)
    if @shift.valid?
      @shift.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def update
    shift = Shift.find(params[:id])
    if shift.update(shift_params)
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    shift = Shift.find(params[:id])
    shift.destroy
    redirect_to request.referer
  end

  def search
    @search_params = search_params
    if @search_params[:start_term].present? && search_params[:end_term].present?
      @shifts = Shift.search(@search_params).includes(:board, :staff_user).order(start_time: 'ASC')
      session[:search] = @shifts.ids
    else
      render :search
    end
  end

  def share
  end

  private

  def shift_params
    params.require(:shift).permit(:start_time, :end_time).merge(staff_user_id: params[:staff_user_id], board_id: params[:board_id])
  end

  def search_params
    params.fetch(:search, {}).permit(:start_term, :end_term).merge(board_id: params[:board_id])
  end

  def except_owner
    redirect_to root_path unless owner_signed_in?
  end

  def correct_owner
    @board = Board.find(params[:board_id])
    redirect_to boards_path if current_owner.id != @board.owner.id
  end

  def index_set
    @shifts = @board.shifts
    @shift = Shift.new
    @staffs = @board.staff_users
  end

  def header_set
    @board = Board.find(params[:board_id])
    gon.board_id = @board.id
    gon.board_name = @board.name
    @board_staff = BoardStaff.new
    @board_staffs = @board.staff_users
    gon.board_staffs_id = @board_staffs.map { |s| s[:id] }
  end
end
