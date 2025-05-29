class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @room = Room.new
    @rooms = Room.public_rooms

    @users = User.all_except(current_user )

    render 'index'
  end

  def show
    @room = Room.new
    @rooms = Room.public_rooms

    @single_room = Room.find(params[:id])

    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)

    @users = User.all_except(current_user )

    render 'index'
  end

  def new
    @room = Room.new
  end

  # def create
  #   @room = Room.new(room_params)
  #   if @room.save
  #     respond_to do |format|
  #       format.turbo_stream
  #       format.html { redirect_to rooms_path, notice: 'Room created successfully.' }
  #     end
  #   else
  #     # Handle form errors
  #     respond_to do |format|
  #       format.turbo_stream
  #       format.html { redirect_to rooms_path, alert: 'Failed to create room.' }
  #     end
  #   end
  # end
  
  def create
    @room = Room.new(room_params)
    
    respond_to do |format|
      if @room.save
        format.turbo_stream
        format.html { redirect_to rooms_path, notice: 'Room created successfully.' }
      else
        format.turbo_stream do
          flash.now[:alert] = 'Failed to create room.'
          render turbo_stream: turbo_stream.replace('new_room_form', partial: 'layouts/new_form', locals: { room: @room })
        end
        format.html do
          redirect_to rooms_path, alert: 'Failed to create room.'
        end
      end
    end
  end
  

  private
  
  def room_params
    params.require(:room).permit(:name, :description)
  end
end
