# Using the class definition from step #3, let's create a few more people --
# that is, Person objects.

# If we're trying to determine whether the two objects contain the same name,
# how can we compare the two objects?

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

  private

  def split_name(full_name)
    name = full_name.split
    self.first_name = name.first
    self.last_name = name[1] ? name.last : ''
  end
end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

p bob.same_name?(rob)

# Solution simply shows `bob.name == rob.name`
