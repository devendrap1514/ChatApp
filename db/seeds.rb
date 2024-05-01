password = "Dev@123"

dev = User.find_or_initialize_by(name: "Devendra", email: "devendrap@shriffle.com") do |user|
  user.password = password
  user.password_confirmation = password
  user.save
end

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

(1..30).each do |i|
  Message.create(content: "Hii-#{i}", sender_id: [raj, karan, shubham, rohit, dev].sample.id, receivable_type: 'User', receivable_id: [raj, karan, shubham, rohit, dev].sample.id)
end

g1 = Group.find_or_initialize_by(name: "The Squad", creator: raj) do |group|
  group.save
end
g2 = Group.find_or_initialize_by(name: "Bro gang", creator: karan) do |group|
  group.save
end
g3 = Group.find_or_initialize_by(name: "BJP", creator: shubham) do |group|
  group.save
end
g4 = Group.find_or_initialize_by(name: "Silence", creator: rohit) do |group|
  group.save
end


(1..10).each do |i|
  Message.create(content: "Hii-#{i}", sender_id: [raj, karan, shubham, rohit, dev].sample.id, receivable_type: 'Group', receivable_id: [g1, g2, g3, g4].sample.id)
end
