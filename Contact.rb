require "./PhoneNumber"
require "./Address"

class Contact
  attr_writer :first_name, :middle_name, :last_name
  attr_reader :phone_numbers, :addresses

  def initialize
    @phone_numbers = []
    @addresses = []
  end

  def add_phone_number(number)
    phone_number = PhoneNumber.new
    phone_number.number = number
    phone_numbers.push(phone_number)
  end

  def add_address(street1, street2, city, state, zip_code)
    address = Address.new
    address.street_1 = street1
    address.street_2 = street2
    address.city = city
    address.state = state
    address.zip_code = zip_code
    addresses.push(address)
  end

  def first_name
    @first_name
  end

  def middle_name
    @middle_name
  end

  def last_name
    @last_name
  end


  def full_name
    full_name = first_name
    if !@middle_name.nil?
      full_name += " "
      full_name += middle_name
    end
    full_name += ' '
    full_name += last_name
    full_name
  end

  def print_phone_numbers
    puts "Phone Number"
    phone_numbers.each { |phone_number| puts phone_number }
  end

  def print_addresses
    puts "Address"
    addresses.each { |address| puts address.to_s('short') }
  end
end