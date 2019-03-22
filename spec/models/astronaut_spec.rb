require 'rails_helper'

describe Astronaut, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many :missions}
  end

  it 'average_age' do
    @a1 = Astronaut.create(name: "one", age: 34, job:"a")
    @a2 = Astronaut.create(name: "two", age: 35, job:"b")
    @a3 = Astronaut.create(name: "three", age: 36, job:"c")

    @m1 = @a1.missions.create(title:"Mission_one", time_in_space: 1)
    @m2 = @a1.missions.create(title:"Mission_two", time_in_space: 2)
    @m2.astronauts << @a2
    @m3 = @a3.missions.create(title:"Mission_three", time_in_space: 3)
    @m3.astronauts << @a2

    expect(35).to eq(Astronaut.avg_age)
  end

  it 'total_time_in_space' do
    @a1 = Astronaut.create(name: "one", age: 34, job:"a")
    @a2 = Astronaut.create(name: "two", age: 35, job:"b")
    @a3 = Astronaut.create(name: "three", age: 36, job:"c")

    @m1 = @a1.missions.create(title:"Mission_one", time_in_space: 1)
    @m2 = @a1.missions.create(title:"Mission_two", time_in_space: 2)
    @m2.astronauts << @a2
    @m3 = @a3.missions.create(title:"Mission_three", time_in_space: 3)
    @m3.astronauts << @a2

    expect(@a1.total_time_in_space).to eq(3)
  end

  it 'missions_ordered' do
    @a1 = Astronaut.create(name: "one", age: 34, job:"a")
    @a2 = Astronaut.create(name: "two", age: 35, job:"b")
    @a3 = Astronaut.create(name: "three", age: 36, job:"c")

    @m1 = @a1.missions.create(title:"Mission_one", time_in_space: 1)
    @m2 = @a1.missions.create(title:"Mission_two", time_in_space: 2)
    @m2.astronauts << @a2
    @m3 = @a3.missions.create(title:"Mission_three", time_in_space: 3)
    @m3.astronauts << @a2

    expect(@a1.missions_ordered).to eq(["Mission_one","Mission_two"])
  end
end
