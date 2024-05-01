password = "Dev@123"

raj = User.find_or_initialize_by(name: "Raj", email: "raj@shriffle.com") do |user|
  user.password = password
  user.password_confirmation = password
  user.save
end
karan = User.find_or_initialize_by(name: "Karan", email: "karan@shriffle.com") do |user|
  user.password = password
  user.password_confirmation = password
  user.save
end
shubham = User.find_or_initialize_by(name: "Shubham", email: "shubham@shriffle.com") do |user|
  user.password = password
  user.password_confirmation = password
  user.save
end
rohit = User.find_or_initialize_by(name: "Rohit", email: "rohit@shriffle.com",) do |user|
  user.password = password
  user.password_confirmation = password
  user.save
end

Group.find_or_initialize_by(name: "The Squad", creator: raj) do |group|
  group.save
end
Group.find_or_initialize_by(name: "Bro gang", creator: karan) do |group|
  group.save
end
Group.find_or_initialize_by(name: "BJP", creator: shubham) do |group|
  group.save
end
Group.find_or_initialize_by(name: "Silence", creator: rohit) do |group|
  group.save
end
