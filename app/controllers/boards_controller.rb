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

  private
  def board_params
    params.require(:board).permit(:name).merge(owner_id: current_owner.id)
  end
end
