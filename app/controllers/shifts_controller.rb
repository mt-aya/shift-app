class ShiftsController < ApplicationController
  before_action :visit_staff_user
  before_action :authenticate_owner!
  before_action :correct_owner, only: [ :index]


  def index
    @board = Board.find(params[:board_id])
    gon.board_id = @board.id
    gon.board_name = @board.name
    @board_staff = BoardStaff.new
    @board_staffs = @board.staff_users
    gon.board_staffs_id = @board_staffs.map { |s| s[:id] }
    get_this_week
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
  def get_this_week
    @todays_date = DateTime.current
    @first_day = @todays_date.beginning_of_week - 1.day
    @last_day = @todays_date.end_of_week - 1.day
    @first_day_str = @first_day.strftime("%Y/%m/%d")
    @last_day_str = @last_day.strftime("%Y/%m/%d")
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']
    @this_week_days = []  #今週の日〜土の順で「年月日(曜日)」を格納

    7.times do |d|
      days = {year: (@first_day + d).year, month: (@first_day + d).month, day: (@first_day + d).day, wday: wdays[d]}
      @this_week_days.push(days)
    end

    @this_week_shifts = []
    board = Board.find(params[:board_id])
    @staff_users = board.staff_users

    @staff_users.each do |staff|
      shifts = staff.shifts.where(start_time: @first_day..@last_day)
      @staff_week_shift = []
      staffs = {staff_id: staff.id, staff_ln: staff.last_name, staff_fn: staff.first_name, days: @staff_week_shift}
      @this_week_shifts.push(staffs)

      7.times do |x|
        day_shift = []
        shifts.each do |shift|
          if shift.start_time.to_date == @first_day.to_date + x
            staff_shifts = {start_time: shift.start_time.strftime("%H:%M"), end_time: shift.end_time.strftime("%H:%M")}
            day_shift.push(staff_shifts)
          end
        end
        @staff_week_shift.push(date: @this_week_days[x], shift: day_shift)
      end
    end

  end
end
