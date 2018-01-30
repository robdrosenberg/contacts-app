require "unirest"

puts "Enter an option number to continue"
puts "[1] See all contacts"
puts "[1.5] See contacts with certain name"
puts "[2] See specific contact"
puts "[3] Create a new contact"
puts "[4] Update contact"
puts "[5] Delete contact"
user_choice = gets.chomp


if user_choice == "1"
  response = Unirest.get("http://localhost:3000/contacts")
  contacts = response.body
  puts JSON.pretty_generate(contacts)
elsif user_choice == "1.5"
  params ={}
  puts "Enter search term"
  search = gets.chomp
  response = Unirest.get("http://localhost:3000/contacts?search=#{search}")
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
  puts "Enter a middle name:"
  params[:middle_name] = gets.chomp
  puts "Enter a last name:"
  params[:last_name] = gets.chomp
  puts "Enter a bio:"
  params[:bio] = gets.chomp
  puts "Enter an email:"
  params[:email] = gets.chomp
  puts "Enter a phone number:"
  params[:phone_number] = gets.chomp
  contact = Unirest.post("http://localhost:3000/contacts",parameters: params)
  puts JSON.pretty_generate(contact)

elsif user_choice == "4"
  puts "Enter id of contact you'd like to update"
  input_id = gets.chomp
  
  response = Unirest.get("http://localhost:3000/contacts/#{input_id}")
  contact = response.body
  contact_params = {}
  puts "Update information for Contact #{input_id}:"
  puts "First Name (#{contact["first_name"]})"
  contact_params[:first_name] = gets.chomp
  puts "Middle Name (#{contact["middle_name"]}):"
  contact_params[:middle_name] = gets.chomp
  puts "Last Name (#{contact["last_name"]}):"
  contact_params[:last_name] = gets.chomp
  puts "Bio:"
  contact_params[:bio] = gets.chomp
  puts "Email (#{contact["email"]}): "
  contact_params[:email] = gets.chomp
  puts "Phone Number (#{contact["phone_number"]})"
  contact_params[:phone_number] = gets.chomp

  contact_params.delete_if {|key,value| value.empty?}

  response = Unirest.patch("http://localhost:3000/contacts/#{input_id}", parameters: contact_params)
  contact = response.body

  puts JSON.pretty_generate(contact)

elsif user_choice == "5"
  puts "Enter ID you want to delete:"
  input_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/contacts/#{input_id}")
  deleted = response.body
  puts deleted["message"]
end


