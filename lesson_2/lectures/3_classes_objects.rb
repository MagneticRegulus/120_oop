# Now create a smart name= method that can take just a first name or a full name,
# and knows how to set the first_name and last_name appropriately.

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

  private

  def split_name(full_name)
    name = full_name.split
    self.first_name = name.first
    self.last_name = name[1] ? name.last : ''
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'

bob.name = "Bob"
p bob.first_name            # => 'Bob'
p bob.last_name             # => '' - They want it to reset
