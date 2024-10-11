# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin.create!(email: "test@hoge.com", password: "testhoge")

administrator = Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = ENV['SECRET_KEY']
end

olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "Olivia"
  user.password = "password"
end

james = User.find_or_create_by!(email: "james@example.com") do |user|
  user.name = "James"
  user.password = "password"
end

lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "Lucas"
  user.password = "password"
end



posts = [
  Post.find_or_create_by!(title: 'サンプル投稿タイトル 1') do |post|
    post.address = '住所 1丁目'
    post.hp = 'https://example1.com'  # サンプルのURL
    post.introduction = 'これはサンプル投稿の内容です。投稿番号 1 に関する情報です。'
    post.user_id = 1
  end,
  Post.find_or_create_by!(title: 'サンプル投稿タイトル 2') do |post|
    post.address = '住所 2丁目'
    post.hp = 'https://example2.com'
    post.introduction = 'これはサンプル投稿の内容です。投稿番号 2 に関する情報です。'
    post.user_id = 2
  end,
  Post.find_or_create_by!(title: 'サンプル投稿タイトル 3') do |post|
    post.address = '住所 3丁目'
    post.hp = 'https://example3.com'
    post.introduction = 'これはサンプル投稿の内容です。投稿番号 3 に関する情報です。'
    post.user_id = 3
  end,
  Post.find_or_create_by!(title: 'サンプル投稿タイトル 4') do |post|
    post.address = '住所 4丁目'
    post.hp = 'https://example4.com'
    post.introduction = 'これはサンプル投稿の内容です。投稿番号 4 に関する情報です。'
    post.user_id = 1
  end,
  Post.find_or_create_by!(title: 'サンプル投稿タイトル 5') do |post|
    post.address = '住所 5丁目'
    post.hp = 'https://example5.com'
    post.introduction = 'これはサンプル投稿の内容です。投稿番号 5 に関する情報です。'
    post.user_id = 2
  end
]