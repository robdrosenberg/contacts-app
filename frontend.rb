require "unirest"

puts "Enter an option number to continue"
puts "[1] See all contacts"
puts "[2] See specific contact"
puts "[3] Create a new contact"
user_choice = gets.chomp


if user_choice == "1"
  response = Unirest.get("http://localhost:3000/contacts")
  contacts = response.body
  puts JSON.pretty_generate(contacts)
elsif user_choice == "2"
  puts "Enter the id of a contact you'd like to see"
  input_id = gets.chomp
  response = Unirest.get("http://localhost:3000/contacts/#{input_id}")
  contact = response.body
  puts JSON.pretty_generate(contact)
elsif user_choice == "3"
  params = {}
  puts "Enter a first name:"
  params[:first_name] = gets.chomp
  puts "Enter a last name:"
  params[:last_name] = gets.chomp
  puts "Enter an email:"
  params[:email] = gets.chomp
  puts "Enter a phone number:"
  params[:phone_number] = gets.chomp
  contact = Unirest.post("http://localhost:3000/contacts",parameters: params)
  puts JSON.pretty_generate(contact)
end