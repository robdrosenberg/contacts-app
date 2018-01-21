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
    contact = Contact.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], phone_number: params[:phone_number])
    render json: contact.as_json
  end

end
