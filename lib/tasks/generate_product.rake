namespace :product do
  desc '產生 10 筆樣本商品'
  task :generate => :environment do
    puts "generating proudcts..."
    10.times { FactoryBot.create(:product) }
    puts "done"
  end
end
