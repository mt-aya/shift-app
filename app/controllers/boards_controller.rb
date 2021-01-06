class BoardsController < ApplicationController

  def index
    owner = Owner.find(current_owner.id)
    @boards = owner.boards.order('created_at DESC')
  end

  def new
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
  end

  def update
    @board = Board.find(params[:id])
    update_board = @board.update!(board_params)
    render json: {board: @board}
  end

  def search
    return nil if params[:keyword] == ""
    results = StaffUser.where(id_name: params[:keyword])
    render json: {results: results}

  end

  private
  def board_params
    params.require(:board).permit(:name).merge(owner_id: current_owner.id)
  end

end
