class AstronautsController < ApplicationController
  def index
    @astronauts = Astronaut.all
    @average_age = Astronaut.avg_age
    # binding.pry
  end

end
