class ContactsController < ApplicationController
  def contact_us
    
  end

  def send_question
    if ContactUsMailer.new_contact_us_message(contact_us_params).deliver_now
      flash[:success] = t('.deliver_success') 
    else
      flash[:alert] = t('.deliver_unsuccess') 
    end

    redirect_to :root
  end

  private

  def contact_us_params
    params.permit(:name, :email, :question_body)
  end
end
