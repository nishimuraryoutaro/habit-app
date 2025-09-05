# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

u = User.find_or_create_by!(email: "demo@example.com") do |x|
  x.password = "password"
end

u.goals.find_or_create_by!(title: "3ヶ月後: TOEIC 750") do |g|
  g.target_date = Date.today + 90
  g.progress = 0
end
