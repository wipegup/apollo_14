require 'rails_helper'

RSpec.describe type: :feature do

  it 'shows astronaut information' do
    @a1 = Astronaut.create(name: "one", age: 34, job:"a")
    @a2 = Astronaut.create(name: "two", age: 35, job:"b")
    @a3 = Astronaut.create(name: "three", age: 36, job:"c")

    @m1 = @a1.missions.create(title:"Mission_one", time_in_space: 1)
    @m2 = @a1.missions.create(title:"Mission_two", time_in_space: 2)
    @m2.astronauts << @a2
    @m3 = @a3.missions.create(title:"Mission_three", time_in_space: 3)
    @m3.astronauts << @a2
    visit astronauts_path

    expect(page).to have_content(@a1.name)
    expect(page).to have_content(@a1.age)
    expect(page).to have_content(@a1.job)

    expect(page).to have_content(@a2.name)
    expect(page).to have_content(@a2.age)
    expect(page).to have_content(@a2.job)

    expect(page).to have_content(@a3.name)
    expect(page).to have_content(@a3.age)
    expect(page).to have_content(@a3.job)
  end

  it 'shows astronaut average age' do
    @a1 = Astronaut.create(name: "one", age: 34, job:"a")
    @a2 = Astronaut.create(name: "two", age: 35, job:"b")
    @a3 = Astronaut.create(name: "three", age: 36, job:"c")

    @m1 = @a1.missions.create(title:"Mission_one", time_in_space: 1)
    @m2 = @a1.missions.create(title:"Mission_two", time_in_space: 2)
    @m2.astronauts << @a2
    @m3 = @a3.missions.create(title:"Mission_three", time_in_space: 3)
    @m3.astronauts << @a2
    visit astronauts_path

    expect(page).to have_content("Average Age: 35")
  end

  it 'shows alphabetical missions' do
    @a1 = Astronaut.create(name: "one", age: 34, job:"a")
    @a2 = Astronaut.create(name: "two", age: 35, job:"b")
    @a3 = Astronaut.create(name: "three", age: 36, job:"c")

    @m1 = @a1.missions.create(title:"Mission_one", time_in_space: 1)
    @m2 = @a1.missions.create(title:"Mission_two", time_in_space: 2)
    @m2.astronauts << @a2
    @m3 = @a3.missions.create(title:"Mission_three", time_in_space: 3)
    @m3.astronauts << @a2
    visit astronauts_path

    expect(page).to have_xpath("//div[@id='mission-info-#{@a1.id}']")
    within "#mission-info-#{@a1.id}" do
      expect(page).to have_content("Mission_one, Mission_two")

    end

    expect(page).to have_xpath("//div[@id='mission-info-#{@a2.id}']")
    within "#mission-info-#{@a2.id}" do
      expect(page).to have_content("Mission_three, Mission_two")

    end

    expect(page).to have_xpath("//div[@id='mission-info-#{@a3.id}']")
    within "#mission-info-#{@a3.id}" do
      expect(page).to have_content("Mission_three")
      
    end
  end

  it 'shows time in space' do
    @a1 = Astronaut.create(name: "one", age: 34, job:"a")
    @a2 = Astronaut.create(name: "two", age: 35, job:"b")
    @a3 = Astronaut.create(name: "three", age: 36, job:"c")

    @m1 = @a1.missions.create(title:"Mission_one", time_in_space: 1)
    @m2 = @a1.missions.create(title:"Mission_two", time_in_space: 2)
    @m2.astronauts << @a2
    @m3 = @a3.missions.create(title:"Mission_three", time_in_space: 3)
    @m3.astronauts << @a2
    visit astronauts_path

    expect(page).to have_xpath("//div[@id='total-time-#{@a1.id}']")
    within "#total-time-#{@a1.id}" do
      expect(page).to have_content("3")
    end

    expect(page).to have_xpath("//div[@id='total-time-#{@a2.id}']")
    within "#total-time-#{@a2.id}" do
      expect(page).to have_content("5")

    end

    expect(page).to have_xpath("//div[@id='total-time-#{@a3.id}']")
    within "#total-time-#{@a3.id}" do
      expect(page).to have_content("3")

    end
  end
end
