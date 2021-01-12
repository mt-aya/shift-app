class ShiftsController < ApplicationController
  before_action :visit_staff_user
  before_action :authenticate_owner!
  before_action :correct_owner, only: [:index]

  def index
    @board = Board.find(params[:board_id])
    gon.board_id = @board.id
    gon.board_name = @board.name
    @board_staff = BoardStaff.new
    @board_staffs = @board.staff_users
    gon.board_staffs_id = @board_staffs.map { |s| s[:id] }
    get_set_week
  end

  private

  def visit_staff_user
    redirect_to root_path if staff_user_signed_in?
  end

  def correct_owner
    @board = Board.find(params[:board_id])
    redirect_to boards_path if current_owner.id != @board.owner.id
  end

  # 今週のシフト一覧作成処理

  def get_set_week
    board = Board.find(params[:board_id])
    @staffs = board.staff_users
    @shifts = board.shifts
  end
end
