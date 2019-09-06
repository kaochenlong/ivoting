# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

puts "Generating 10 candidates..."
10.times do |i|
  Candidate.create(name: Faker::TvShows::GameOfThrones.character,
                   party: Faker::TvShows::GameOfThrones.house,
                   degree: ['國中', '高中', '大學', '研究所'].sample,
                   age: Faker::Number.between(from: 40, to: 100),
                   policy: Faker::TvShows::GameOfThrones.quote)
end
puts "Done!"