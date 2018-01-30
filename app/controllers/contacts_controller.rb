class ContactsController < ApplicationController

  def index
    contacts = Contact.all
    search = params[:search]
    if search
      contacts = contacts.where("first_name LIKE ? OR last_name LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
    end
    render json: contacts.as_json
  end

  def show
    contact = Contact.find_by(id: params[:id])
    render json: contact.as_json
  end

  def create
    contact = Contact.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      middle_name: params[:middle_name],
      bio: params[:bio],
      email: params[:email], 
      phone_number: params[:phone_number]
    )
    if contact.save
      render json: contact.as_json
    else
      render json: {
        error: contact.errors.full_message, 
        message: :unprocessable_entity}
    end
  end

  def update
    contact = Contact.find_by(id: params[:id])
    contact.first_name = params[:first_name] || contact.first_name

    contact.last_name = params[:last_name] || contact.last_name

    contact.middle_name = params[:middle_name] || contact.middle_name

    contact.bio = params[:bio] || contact.bio
    contact.email = params[:emmail] || contact.email
    contact.phone_number = params[:phone_number] || contact.phone_number
    if contact.save
      render json: contact.as_json
    else
      render json: {
        error: contact.errors.full_message, 
        message: :unprocessable_entity}
    end
  end

  def destroy
    contact = Contact.find_by(id: params[:id])
    contact.destroy
    render json: {message: "Your contact has been deleted!"}
  end

end
