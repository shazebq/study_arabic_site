class MessagesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :destroy, :destroy_multiple, :index, :new_reply, :create_reply, :show] 
  before_filter :messages_belong_to_current_user, only: :index
  before_filter :only_recipient_can_reply, only: [:new_reply, :create_reply]
  before_filter :cannot_message_yourself, only: [:new, :create]
  before_filter :must_be_sender_or_recipient, only: [:show, :destroy]
  before_filter :mark_as_read, only: :show

  def index
    @received_messages = User.find(params[:user_id]).received_messages.active_messages("recipient")
    @sent_messages = User.find(params[:user_id]).sent_messages.active_messages("sender")
  end
  
  def new
    @user = User.find(params[:user_id])
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    # sender_id should be current_user.id and receiver_id should be params[:user_id]
    @message.sender = current_user
    @message.recipient = User.find(params[:user_id])
    if @message.save
      flash[:notice] = "Your message has been successfully sent"
      # send alert email
      UserMailer.delay.message_alert(@message.recipient, @message.sender, @message)
      redirect_to user_path(params[:user_id])
    else
      render "new"
    end
  end

  def new_reply
    @parent = Message.find(params[:id])
    @message = Message.new
  end

  def create_reply
    @parent = Message.find(params[:id])
    if @parent.conversation
      @message = @parent.conversation.replies.new(params[:message]) # it's a reply to a reply
    else
      @message = @parent.replies.new(params[:message]) # it's a reply to the original
    end
    @message.sender = current_user
    @message.recipient = @parent.sender
    if @message.save
      flash[:notice] = "Your reply has been successfully sent"
      UserMailer.delay.message_alert(@message.recipient, @message.sender, @message)
      redirect_to user_messages_path(current_user)
    else
      render "new_reply"
    end
  end

  def show
    @message = Message.find(params[:id]) 
  end

  # doesn't actually delete, just changes the attribute
  def destroy
    # no specific filter required because conditions are contained in the method itself
    @message = Message.find(params[:id])
    if current_user == @message.sender
      @message.update_attributes(sender_delete: true)
    elsif current_user == @message.recipient
      @message.update_attributes(recipient_delete: true)
    end
    flash[:notice] = "Your message has been successfully deleted"
    redirect_to user_messages_path(current_user)
  end

  def destroy_multiple
    unless params[:message_ids].blank?
      Message.mark_list_as_deleted(params[:message_ids], current_user)
      flash[:notice] = "Your messages have been successfully deleted"
    end
    redirect_to user_messages_path(current_user)
  end

  # before filters
  # ensures user can acces their own mailbox only
  def messages_belong_to_current_user
    unless current_user == User.find(params[:user_id])
      redirect_to root_path 
    end
  end

  def only_recipient_can_reply
    unless current_user == Message.find(params[:id]).recipient
      redirect_to root_path
    end
  end

  def cannot_message_yourself
    if current_user == User.find(params[:user_id])
      flash[:notice] = "You cannot send yourself a message"
      redirect_to :back
    end
  end

  def must_be_sender_or_recipient
    message = Message.find(params[:id])
    unless current_user == message.recipient || current_user == message.sender
      redirect_to root_path
    end
  end

  def mark_as_read
    message = Message.find(params[:id])
    if message.recipient == current_user
      message.update_attributes(checked: true)
    end
  end
end
