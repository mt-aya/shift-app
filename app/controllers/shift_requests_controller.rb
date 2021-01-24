class ShiftRequestsController < ApplicationController

  def index
    if staff_user_signed_in?
      @shift_requests = current_staff_user.shift_requests
      @shifts = current_staff_user.shifts
      @shift_request = ShiftRequest.new
    end
  end
end
