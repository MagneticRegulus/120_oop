=begin
Befor making changes to the class, what would the below code print?

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
# => This person's name is #<Person:0x0.......>
=end

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    split_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    split_name(full_name)
  end

  def same_name?(other_person)
    name == other_person.name
  end

  def to_s
    name
  end

  private

  def split_name(full_name)
    name = full_name.split
    self.first_name = name.first
    self.last_name = name[1] ? name.last : ''
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

# After adding in a custom #to_s method, this should print as expected.
