class ShiftsController < ApplicationController
  before_action :visit_staff_user
  before_action :authenticate_owner!
  before_action :correct_owner, only: [:index]
  before_action :board_staff, only: [:index, :new]

  def index
    gon.board_id = @board.id
    gon.board_name = @board.name
    @board_staff = BoardStaff.new
    @board_staffs = @board.staff_users
    # gon.board_staffs_id = @board_staffs.map { |s| s[:id] }
    @shifts = @board.shifts
    @shift = Shift.new
  end

  def create
    @board = Board.find(params[:board_id])
    @shift = Shift.new(shift_params)
    if @shift.valid?
      @shift.save
      redirect_to board_shifts_path(@board.id)
    else
      render :index
    end
  end

  private

  def shift_params
    params.require(:shift).permit(:start_time, :end_time,).merge(staff_user_id: params[:staff_user_id], board_id: params[:board_id])
  end

  def visit_staff_user
    redirect_to root_path if staff_user_signed_in?
  end

  def correct_owner
    @board = Board.find(params[:board_id])
    redirect_to boards_path if current_owner.id != @board.owner.id
  end

  def board_staff
    @board = Board.find(params[:board_id])
    @staffs = @board.staff_users
  end

end
