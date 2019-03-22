class Astronaut < ApplicationRecord
  validates_presence_of :name, :age, :job

  has_many :astronaut_missions
  has_many :missions, through: :astronaut_missions

  def self.avg_age
    average(:age)
  end

  def total_time_in_space
    missions.sum(:time_in_space)
  end

  def missions_ordered
    missions.order(:title).pluck(:title)
  end
end
