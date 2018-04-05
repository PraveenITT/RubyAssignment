class Address
  attr_accessor  :street_1, :street_2, :city, :state, :zip_code

  def to_s(format = 'short')
    address = ''
    case format
      when 'short'
        address += street_1
        if street_2
          address += " " + street_2
        end
        address += ", #{city}, #{state} #{zip_code}"
      when 'long'
        address += street_1 + "\n"
        address += street_2 + "\n" if !street_2.nil?
        address += "#{city}, #{state} #{zip_code}"
    end #case
  end #def to_s

end #class Address