class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @room = Room.new
    @rooms = Room.public_rooms

    @users = User.all_except(current_user )
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to rooms_path, notice: 'Room created successfully.' }
      end
    else
      # Handle form errors
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to rooms_path, alert: 'Failed to create room.' }
      end
    end
  end
  
  private
  
  def room_params
    params.require(:room).permit(:name, :description)
  end
end
