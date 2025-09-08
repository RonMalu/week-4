# File I/O
  #input/read
  #output/write

  #different file modes
    # r - read
    # r+ - read and write without creating a new file if th file doesnt exist
    # w - write -- overwrite the entire file
    # w+ - read and write with creating a new file if the file doesnt exist
    # a - append - add to the bottom of the file
    # a+ -


# begin
#   file = File.open("oop-review.rb", "r")  
#   contents = file.read
# rescue Errno::ENOENT
#   PUTS "File not found"

#   puts contents
#   ensure
#   file.close if file #if file is not nil, close it
# end 


# Exercise:
# Task: Read data from a file.
# Instructions:
# Create a file named example.txt with some sample text.

# Create a Ruby script named file-io.rb.

# Use the provided code to read and display the file contents.

# Run the script and observe the output.

# Test the error handling by renaming or deleting example.txt and running the script again.

# Change your script to read a different file and have it print out the contents.

# begin
#   file = File.open("/home/jrnxf/csg-lab/week-3/practice.08.28.rb", "r")
#   contents = file.read
#   puts contents
# rescue Errno::ENOENT
#   puts " File not found."

# ensure
#   file.close if file
# end 


#write
  # begin 
  #   file = File.open("file.txt", "w")
  #   file.puts "Hello class"

  # rescue
  #   puts "An error occured"
  # ensure
  #   file.close if file
  # end 


# Task: Write user input to a file.
# Instructions:
# Prompt the user for their name and a message.

# Write this information to a file named user_messages.txt (do not create this file manually).

# Ensure proper error handling and closing of the file.

# Test it out and see how it created a new file named user_messages.txt with that message.
# Test it out again and see how it deletes everything in user_messages.txt and adds the new message.

# Now that you’ve seen that ‘w’ overwrites everything, now change ‘w’ to ‘a’ for append and test it again to see how it appends to the end of the file rather than overwriting it.

# Test it multiple times to see how it continues to add to the file rather than delete everything.

# begin
#   file = File.open("user_messages.txt", "a")

#   puts " what is your name?"
#   input = gets.chomp
#   puts "Nice to meet you!"
#   puts "Success!"

# rescue 
#   puts "Error occured."

# ensure
#   file.close if file
# end 

#wrong











# puts "whats your name?"
# name = gets.chomp

# puts "whats a message you want to share?"
# message = gets.chomp

# begin 
#   file = File.open("user_messages.txt", "w")
#   file.puts "#{name}: #{message}"
#   puts "your message has been saved"
# rescue
#   puts "An error has occured"
# ensure
#   file.close if file
# end 


# Task: Count the number of lines in a file.
# Instructions:

# Read a file and count the number of lines.

# Display the total line count.

# Include error handling for file not found.


# begin
#   file = File.open("/home/jrnxf/csg-lab/week-3/practice.08.28.rb", "r")
#   file.each_with_index do |line, index|
#     puts "#{index + 1}.Read line: #{line}"
#     if line.include?("testing")
#       puts "lines containing testing:"
#     end 

#   end 
#   # file.each_line do |line|
#   #   if line.include?("puts")
#   #     puts " lines containing 'puts'"
#   #   end 
# rescue Errno::ENOENT
#   puts "file not found."
# ensure
#   file.close if file
# end 

# Define an array of hashes representing contacts.
# Write the array to a file named contacts.json in JSON format.
# Ensure proper error handling.

# require 'json'

# contacts = [
#   {name: "person1", number:"cont1", village: "res1"},
#   {name: "person1", number:"cont2", village: "res2"},
#   {name: "person3", number:"cont3", village: "res3"}
# ]

# begin
#   file = File.open("contacts.json", "w")
#   file.write(JSON.pretty_generate(contacts))
#   puts "contacts saved on contacts.json"
# rescue
#   puts "Error"
# ensure
#   file.close if file 
# end 



require 'json'

contacts = []

if File.exist?("contacts.json")
  begin
    file = File.open("contacts.json", "r")
    contacts = JSON.parse(file.read, symbolize_names: true)
    puts "Contacts loaded successfully"
  rescue => e
    puts "error: #{e}"
  ensure
    file.close if file
  end
else
  puts "No contacts found. Starting with an empty contact list."
end

def save_contacts(contacts)
  begin
    file = File.open("contacts.json", "w")
    file.write(JSON.pretty_generate(contacts))
    puts "Contacts saved!"
  rescue
    puts "Error"
  ensure
    file.close if file
  end
end

loop do
  puts "\nContact List Menu:"
  puts "1. Add contact"
  puts "2. Remove contact"
  puts "3. View contacts"
  puts "4. Exit"
  puts "Enter your choice: "
  choice = gets.chomp.to_i

  case choice
  when 1
    puts "Enter contact name: "
    name = gets.chomp
    puts "Enter contact phone number: "
    phone = gets.chomp
    puts "Enter contact email: "
    email = gets.chomp
    contacts.push({ name: name, phone: phone, email: email })
    puts "Contact added."
  when 2
    puts "Enter contact name to remove: "
    name = gets.chomp
    contact = contacts.find { |c| c[:name] == name }
    if contact
      contacts.delete(contact)
      puts "Contact removed."
    else
      puts "Contact not found."
    end
  when 3
    puts "Contact List:"
    contacts.each_with_index do |contact, index|
      puts "#{index + 1}. #{contact[:name]} - #{contact[:phone]} - #{contact[:email]}"
    end
  when 4
    save_contacts(contacts)
    puts "Goodbye!"
    break
  else
    puts "Invalid choice. Please try again."
  end
end