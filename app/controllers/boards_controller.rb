class BoardsController < ApplicationController
  before_action :visit_staff_user
  before_action :authenticate_owner!
  before_action :correct_owner, only: [:show, :update, :search, :invite]

  def index
    @boards = current_owner.boards.order('created_at ASC')
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    if @board.valid?
      @board.save
      redirect_to boards_path
    else
      render :new
    end
  end

  def show
    @board = Board.find(params[:id])
    gon.board_id = @board.id
    gon.board_name = @board.name
    @board_staff = BoardStaff.new
    @board_staffs = @board.staff_users
    gon.board_staffs_id = @board_staffs.map { |s| s[:id] }
  end

  def update
    @board = Board.find(params[:id])
    update_board = @board.update!(board_params)
    render json: { board: @board }
  end

  def search
    @results = StaffUser.search(params[:keyword])
    render json: { results: @results }
  end

  def invite
    @board_staff = BoardStaff.new(board_staff_params)
    if @board_staff.valid?
      result_staff = @board_staff.save
      render json: { result: result_staff }
    end
  end

  private

  def board_params
    params.require(:board).permit(:name).merge(owner_id: current_owner.id)
  end

  def board_staff_params
    params.require(:board_staff).permit(:id_name).merge(board_id: params[:id])
  end

  def visit_staff_user
    redirect_to root_path if staff_user_signed_in?
  end

  def correct_owner
    @board = Board.find(params[:id])
    redirect_to boards_path if current_owner.id != @board.owner.id
  end
end
