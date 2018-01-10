class MyCar
  attr_accessor :year, :color, :model, :speed

  def initialize(y, c, m)
    self.year = y
    self.color = c
    self.model = m
    self.speed = 0
  end

  def speed_up(n=5)
    @speed += n
  end

  def brake(n=5)
    @speed -= n
    self.speed = 0 if speed < 0
  end

  def turn_off
    self.speed = 0
  end

end

car = MyCar.new(2016, 'black', 'Tesla')
car.speed_up
p car.speed
car.speed_up(50)
p car.speed
car.brake
p car.speed
car.brake(15)
p car.speed
car.turn_off
p car.speed
