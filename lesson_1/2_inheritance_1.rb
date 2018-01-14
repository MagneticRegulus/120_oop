module Haulable
  def haul
    "I can pickup and unload goods."
  end
end

class Vehicle
  attr_accessor :color, :speed
  attr_reader :year, :model

  @@total_vehicles = 0

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
    @@total_vehicles += 1
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

  def to_s
    "Year: #{year}. Model: #{model}. Color: #{color}."
  end

  def self.total_vehicles
    @@total_vehicles
  end

  def self.gas_mileage(prev, curr, gallons)
    mileage = (curr - prev) / gallons
    puts "#{mileage} miles per gallon."
  end

  def age
    calc_age
  end

  private

  def calc_age
    Time.new.year - year
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
end

class MyTruck < Vehicle
  include Haulable

  NUMBER_OF_DOORS = 2
end

toyota = MyCar.new(1999, 'biege', 'Avalon')
ford = MyTruck.new(2004, 'blue', 'Pickup')
puts toyota
puts ford
p Vehicle.total_vehicles
p ford.haul
# p toyota.haul # => NoMethod Error

puts

puts "-----MyCar lookup-----"
puts MyCar.ancestors
puts "-----MyTruck lookup-----"
puts MyTruck.ancestors
puts "-----Vehicle lookup-----"
puts Vehicle.ancestors

toyota.speed_up(20)
p toyota.speed
toyota.brake
p toyota.speed
toyota.turn_off
p toyota.speed

ford.speed_up(20)
p ford.speed
ford.brake
p ford.speed
ford.turn_off
p ford.speed

toyota.spray_paint('red')
puts toyota
MyCar.gas_mileage(300, 650, 25)

p toyota.age
p ford.age
# p toyota.calc_age # => NoMethodError
