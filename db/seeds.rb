password = "Dev@123"

total = 20
(1..total).each do |i|
  User.find_or_initialize_by(name: "User-#{i}", email: "user#{i}@shriffle.com",) do |user|
    user.password = password
    user.password_confirmation = password
    user.save
  end
end

(1..30).each do |i|
  Message.create(content: "Hii-#{i}", sender_id: User.all.sample.id, receivable_type: 'User', receivable_id: User.all.sample.id)
end

(1..10).each do |i|
  Group.find_or_initialize_by(name: "Group-#{i}", creator: User.all.sample) do |group|
    group.save
  end
end

(1..10).each do |i|
  UserGroup.find_or_initialize_by(user: User.all.sample, group: Group.all.sample) do |ug|
    ug.save
  end
end

(1..10).each do |i|
  Message.find_or_initialize_by(content: "Hii-#{i}", sender_id: User.all.sample.id, receivable_type: 'Group', receivable_id: Group.all.sample.id)
end
