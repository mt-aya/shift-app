class BoardsController < ApplicationController

  def index
    owner = Owner.find(current_owner.id)
    @boards = owner.boards.order('created_at DESC')
  end

  def new
    @board = Board.new
  end
end
