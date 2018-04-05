require "./Contact"
require "yaml"

class AddressBook
  attr_reader :contacts

  def initialize
    @contacts = []
    open()
  end #initialize

  def run
    loop do
      puts "Address Book"
      puts "Press 'a': Add New Contact"
      puts "Press 's': Search Contacts"
      puts "Press 'p': Print Address Book"
      puts "Press 'e': Exit"
      print "Enter your choice: "
      input = gets.chomp.downcase
      case input
        when 'e'
          exit_save()
          break
        when 'p'
          print_contact_list
        when 'a'
          add_contact
        when 's'
          print "Enter Name to be search: "
          search = gets.chomp
          find_by_name(search)
      end #case
    end #loop
  end #def (run)

  def open
    if File.exist?("contacts.yml")
      contacts = YAML.load_file("contacts.yml")
    end
  end #def (open)

  def exit_save
    File.open("contacts.yml", "w") do |file|
      file.write(contacts.to_yaml)
    end #file.open
  end #def (open)

  def add_contact
    contact = Contact.new
    print "First_Name: "
    contact.first_name = gets.chomp
    print "Middle_Name: "
    contact.middle_name = gets.chomp
    print "Last_Name: "
    contact.last_name = gets.chomp
    contacts.push(contact)

    loop do
      puts "Add a phone number or address? "
      puts "Press 'p': Add phone number"
      puts "Press 'a': Add address"
      puts "Enter any other key to go back"
      response = gets.chomp.downcase
      case response
        when 'p'
          phone = PhoneNumber.new
          print "Number: "
          phone.number = gets.chomp
          contact.phone_numbers.push(phone)
        when 'a'
          address = Address.new
          print "Address line 1: "
          address.street_1 = gets.chomp
          print "Address line 2: "
          address.street_2 = gets.chomp
          print "City: "
          address.city = gets.chomp
          print "State: "
          address.state = gets.chomp
          print "Postal Code: "
          address.zip_code = gets.chomp
          contact.addresses.push(address)
        else
          print "\n"
          break
      end #case
    end #loop
  end #def (add_contact)


  def print_contact_list
    puts "Contact List:" + "\n"
    contacts.each do |contact|
      puts "\n" + contact.full_name
      contact.print_phone_numbers
      contact.print_addresses
    end #each
  end #def print_contact_list

  def find_by_name(name)
    results = []
    search = name.downcase
    # Collect search results
    contacts.each do |contact|
      if contact.full_name.downcase.include?(search)
        results.push(contact)
      end #if
    end #each
    print_results("Name search results (#{search}):", results)
  end #def find_by_name


  def print_results(search_label, results)
    puts search_label
    results.each do |contact|
      puts "\n" + contact.full_name
      contact.print_phone_numbers
      contact.print_addresses
    end
  end #def (print_results)

end #class AddressBook

address_book = AddressBook.new
address_book.run