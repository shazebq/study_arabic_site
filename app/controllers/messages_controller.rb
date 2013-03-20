class MessagesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :index]

  def index
    @received_messages = User.find(params[:user_id]).received_messages
    @sent_messages = User.find(params[:user_id]).sent_messages
  end

  def new
    @user = User.find(params[:user_id])
    @message = Message.new
  end

  def create
    @user = User.find(params[:user_id])
    @message = Message.new(params[:message])
    # sender_id should be current_user.id and receiver_id should be params[:user_id]
    @message.sender = current_user
    @message.recipient = User.find(params[:user_id])
    if @message.save
      flash[:notice] = "Your message has been sent"
      redirect_to user_path(params[:user_id])
    else
      render "new"
    end
  end

  def show
    @message = Message.find(params[:id]) 
  end
end
