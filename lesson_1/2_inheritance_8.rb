class Person
  # private

  def hi
    puts "Hi!"
  end
end

bob = Person.new
bob.hi

# Fixed the issue by unprivatizing the `hi` method, should go before keyword
