# If I have the following class:
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# What would happen if I called the methods like shown below?
tv = Television.new
tv.manufacturer # NoMethodError, this is a class method
tv.model # returns Television#model

Television.manufacturer # get a return value
Television.model # NoMethodError
