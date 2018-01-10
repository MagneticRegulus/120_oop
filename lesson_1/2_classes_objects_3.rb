class MyCar
  attr_accessor :color, :speed
  attr_reader :year, :model

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def speed_up(n=5)
    @speed += n
  end

  def turn_off
    @speed = 0
  end

  def brake(n=5)
    @speed -= n
    turn_off if speed < 0
  end

  def spray_paint(c)
    self.color = c
  end

  def self.gas_mileage(prev, curr, gallons)
    mileage = (curr - prev) / gallons
    puts "#{mileage} miles per gallon."
  end

  def to_s
    "My car is a #{year}, #{color} #{model}."
  end

end

MyCar.gas_mileage(2678, 3500, 23)
car = MyCar.new(2016, 'black', 'Tesla')
puts car
