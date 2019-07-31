1.upto(10) do |i|
  Vertical.create(name: "Vertical ##{i}")
end

Vertical.all.each_with_index do |vertical, i|
  Category.create(name: "Category ##{i}", vertical_id: vertical.id)
end

Category.all.each_with_index do |category, i|
  Course.create(name: "Course ##{i}", author: "Author ##{i}", category_id: category.id)
end

User.create(email: 'test@test.com', password: '123456')
