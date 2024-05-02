(1..10000).each do |i|
  Person.create(name: "Hello-#{i}", dob: (Time.now-19.years+i.hours))
end
