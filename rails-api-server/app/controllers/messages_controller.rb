class MessagesController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :set_chat_room
  before_action :set_chat_room_message, only: [:show, :update, :destroy]

  # GET /chat_rooms/:chat_room_id/messages
  def index
    json_response(@chat_room.messages)
  end

  # GET /chat_rooms/:chat_room_id/messages/:id
  def show
    json_response(@message)
  end

  # POST /chat_rooms/:chat_room_id/messages
  def create
    @chat_room.messages.create!(message_params)
    json_response(@chat_room, :created)
  end

  # PUT /chat_rooms/:chat_room_id/messages/:id
  def update
    @message.update(message_params)
    head :no_content
  end

  # DELETE /chat_rooms/:chat_room_id/messages/:id
  def destroy
    @message.destroy
    head :no_content
  end

  private

  def message_params
    params.permit(:body, :chat_room_id, :user_id)
  end

  def set_chat_room
    @chat_room = ChatRoom.find(params[:chat_room_id])
  end

  def set_chat_room_message
    @message = @chat_room.messages.find_by!(id: params[:id]) if @chat_room
  end
end