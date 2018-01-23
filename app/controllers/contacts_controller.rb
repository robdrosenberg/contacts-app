class ContactsController < ApplicationController

  def index
    contacts = Contact.all
    render json: contacts.as_json
  end

  def show
    contact = Contact.find_by(id: params[:id])
    render json: contact.as_json
  end

  def create
    contact = Contact.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      middle_name: params[:middle_name],
      bio: params[:bio],
      email: params[:email], 
      phone_number: params[:phone_number]
    )
    render json: contact.as_json
  end

  def update
    contact = Contact.find_by(id: params[:id])
    contact.update(
      first_name: params[:first_name] || contact.first_name,
      last_name: params[:last_name] || contact.last_name,
      middle_name: params[:middle_name] || contact.middle_name,
      bio: params[:bio] || contact.bio,
      email: params[:emmail] || contact.email,
      phone_number: params[:phone_number] || contact.phone_number
      )
    render json: contact.as_json
  end

  def destroy
    contact = Contact.find_by(id: params[:id])
    contact.destroy
    render json: {message: "Your contact has been deleted!"}
  end

end
