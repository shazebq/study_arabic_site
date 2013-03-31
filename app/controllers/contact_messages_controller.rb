class ContactMessagesController < ApplicationController

  def new
    @contact_message = ContactMessage.new
  end

  def create
    @contact_message = ContactMessage.new(params[:contact_message])
    if @contact_message.valid?
      ContactMessageMailer.new_message(@contact_message).deliver
      flash[:notice] = "Your message has been successfully sent."
      redirect_to root_path
    else
      render "new"
    end
  end
end
