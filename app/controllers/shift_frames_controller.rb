class ShiftFramesController < ApplicationController

  def index
    @shift_frame = ShiftFrame.new
    @board = Board.find(params[:board_id])
    @shift_frames = @board.shift_frames
  end

  def create
    @shift_frame = ShiftFrame.new(shift_frame_params)
    @board = Board.find(params[:board_id])
    if @shift_frame.valid?
      @shift_frame.save
      redirect_to board_shift_frames_path(@board.id)
    else
      render :index
    end
  end

  private

  def shift_frame_params
    params.require(:shift_frame).permit(:start_day, :end_day).merge(board_id: params[:board_id])
  end
end
