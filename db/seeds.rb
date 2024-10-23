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
    post.hp = 'https://example1.com'
    post.introduction = 'これはサンプル投稿の内容です。投稿番号 1 に関する情報です。'
    post.user_id = User.find_by(email: 'olivia@example.com').id
    post.is_active = true  # 明示的にis_activeを設定
  end,
  Post.find_or_create_by!(title: 'サンプル投稿タイトル 2') do |post|
    post.address = '住所 2丁目'
    post.hp = 'https://example2.com'
    post.introduction = 'これはサンプル投稿の内容です。投稿番号 2 に関する情報です。'
    post.user_id = User.find_by(email: 'james@example.com').id
    post.is_active = true
  end,
  Post.find_or_create_by!(title: 'サンプル投稿タイトル 3') do |post|
    post.address = '住所 3丁目'
    post.hp = 'https://example3.com'
    post.introduction = 'これはサンプル投稿の内容です。投稿番号 3 に関する情報です。'
    post.user_id = User.find_by(email: 'lucas@example.com').id
    post.is_active = true
  end,
  Post.find_or_create_by!(title: 'サンプル投稿タイトル 4') do |post|
    post.address = '住所 4丁目'
    post.hp = 'https://example4.com'
    post.introduction = 'これはサンプル投稿の内容です。投稿番号 4 に関する情報です。'
    post.user_id = User.find_by(email: 'olivia@example.com').id
    post.is_active = true
  end,
  Post.find_or_create_by!(title: 'サンプル投稿タイトル 5') do |post|
    post.address = '住所 5丁目'
    post.hp = 'https://example5.com'
    post.introduction = 'これはサンプル投稿の内容です。投稿番号 5 に関する情報です。'
    post.user_id = User.find_by(email: 'james@example.com').id
    post.is_active = true
  end
]

tags = [
  '大型犬向け',
  '中型犬向け',
  '小型犬向け',
  '駐車場完備',
  '公共交通機関でアクセス可能',
  'トイレ完備',
  'ベンチあり',
  'ゴミ箱設置',
  '予約必要',
  'しつけ教室あり',
  'ドッグカフェあり',
  'エリア分けあり',
  'プールあり',
  'アジリティ設備あり'
]
tags.each do |tag_name|
  Tag.find_or_create_by!(name: tag_name)
end


comments = [
  Comment.find_or_create_by!(comment: 'とても良いドッグランでした！また来たいです。', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '5', safety_star: '5', cost_star: '4', user_id: olivia.id, post_id: posts[0].id),
  Comment.find_or_create_by!(comment: 'スタッフが親切で、安心して遊ばせられました。', total_star: '4', extent_star: '4', clean_star: '4', amenity_star: '5', safety_star: '5', cost_star: '3', user_id: james.id, post_id: posts[1].id),
  Comment.find_or_create_by!(comment: '設備が整っていて、犬も楽しんでいました。', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '4', safety_star: '5', cost_star: '4', user_id: lucas.id, post_id: posts[2].id),
  Comment.find_or_create_by!(comment: '混雑していましたが、楽しめました！', total_star: '4', extent_star: '3', clean_star: '4', amenity_star: '4', safety_star: '4', cost_star: '5', user_id: olivia.id, post_id: posts[3].id),
  Comment.find_or_create_by!(comment: 'ドッグカフェの食べ物が美味しかったです！', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '5', safety_star: '5', cost_star: '4', user_id: james.id, post_id: posts[4].id),
  Comment.find_or_create_by!(comment: '大型犬も安心して遊べました。', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '4', safety_star: '5', cost_star: '4', user_id: olivia.id, post_id: posts[0].id),
  Comment.find_or_create_by!(comment: 'もっと広いエリアがあれば嬉しいです。', total_star: '3', extent_star: '4', clean_star: '3', amenity_star: '4', safety_star: '4', cost_star: '5', user_id: james.id, post_id: posts[1].id),
  Comment.find_or_create_by!(comment: 'トイレがきれいで、便利でした。', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '5', safety_star: '5', cost_star: '4', user_id: lucas.id, post_id: posts[2].id),
  Comment.find_or_create_by!(comment: '犬が自由に遊べて嬉しいです。', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '5', safety_star: '5', cost_star: '5', user_id: olivia.id, post_id: posts[3].id),
  Comment.find_or_create_by!(comment: '大きなプールがあって、犬が楽しそうでした。', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '4', safety_star: '5', cost_star: '4', user_id: james.id, post_id: posts[4].id),
  Comment.find_or_create_by!(comment: 'しつけ教室があって、とても役立ちました。', total_star: '4', extent_star: '4', clean_star: '4', amenity_star: '5', safety_star: '5', cost_star: '4', user_id: lucas.id, post_id: posts[0].id),
  Comment.find_or_create_by!(comment: '料金が少し高めですが、価値があります。', total_star: '4', extent_star: '4', clean_star: '4', amenity_star: '4', safety_star: '4', cost_star: '3', user_id: olivia.id, post_id: posts[1].id),
  Comment.find_or_create_by!(comment: 'エリア分けがあり、安心して遊ばせられます。', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '5', safety_star: '5', cost_star: '4', user_id: james.id, post_id: posts[2].id),
  Comment.find_or_create_by!(comment: 'ベンチがたくさんあり、休憩しやすかったです。', total_star: '4', extent_star: '4', clean_star: '4', amenity_star: '5', safety_star: '5', cost_star: '3', user_id: lucas.id, post_id: posts[3].id),
  Comment.find_or_create_by!(comment: 'ゴミ箱が設置されていて、環境が良いです。', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '5', safety_star: '5', cost_star: '4', user_id: olivia.id, post_id: posts[4].id),
  Comment.find_or_create_by!(comment: '予約が必要ですが、スムーズに入れました。', total_star: '4', extent_star: '4', clean_star: '4', amenity_star: '4', safety_star: '4', cost_star: '3', user_id: james.id, post_id: posts[0].id),
  Comment.find_or_create_by!(comment: '犬が遊ぶのにとても良い場所です！', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '5', safety_star: '5', cost_star: '5', user_id: lucas.id, post_id: posts[1].id),
  Comment.find_or_create_by!(comment: '中型犬向けに最適でした。', total_star: '4', extent_star: '4', clean_star: '4', amenity_star: '4', safety_star: '4', cost_star: '4', user_id: olivia.id, post_id: posts[2].id),
  Comment.find_or_create_by!(comment: '遊び場が充実していて、犬が楽しんでいました。', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '5', safety_star: '5', cost_star: '4', user_id: james.id, post_id: posts[3].id),
  Comment.find_or_create_by!(comment: 'スタッフの対応がとても良かったです。', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '5', safety_star: '5', cost_star: '5', user_id: lucas.id, post_id: posts[4].id),
  Comment.find_or_create_by!(comment: 'ドッグカフェも利用しましたが、味も良かったです。', total_star: '4', extent_star: '4', clean_star: '4', amenity_star: '5', safety_star: '5', cost_star: '4', user_id: olivia.id, post_id: posts[0].id),
  Comment.find_or_create_by!(comment: '安全に遊べるエリアがあって安心しました。', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '4', safety_star: '5', cost_star: '4', user_id: james.id, post_id: posts[1].id),
  Comment.find_or_create_by!(comment: '子供連れでも楽しめる場所です。', total_star: '4', extent_star: '4', clean_star: '4', amenity_star: '5', safety_star: '5', cost_star: '4', user_id: lucas.id, post_id: posts[2].id),
  Comment.find_or_create_by!(comment: '遊ぶ場所が広く、犬が満足していました。', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '5', safety_star: '5', cost_star: '5', user_id: olivia.id, post_id: posts[3].id),
  Comment.find_or_create_by!(comment: '日陰があって、夏でも快適に過ごせました。', total_star: '4', extent_star: '4', clean_star: '4', amenity_star: '5', safety_star: '5', cost_star: '3', user_id: james.id, post_id: posts[4].id),
  Comment.find_or_create_by!(comment: 'エリアが分かれていて、安心して遊ばせられます。', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '5', safety_star: '5', cost_star: '4', user_id: lucas.id, post_id: posts[0].id),
  Comment.find_or_create_by!(comment: '何度も来ているお気に入りの場所です。', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '5', safety_star: '5', cost_star: '5', user_id: olivia.id, post_id: posts[1].id),
  Comment.find_or_create_by!(comment: '犬が大好きな場所で、毎週通っています。', total_star: '4', extent_star: '4', clean_star: '4', amenity_star: '4', safety_star: '4', cost_star: '4', user_id: james.id, post_id: posts[2].id),
  Comment.find_or_create_by!(comment: 'エリアが広くて、走り回れて嬉しいです。', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '5', safety_star: '5', cost_star: '5', user_id: lucas.id, post_id: posts[3].id),
  Comment.find_or_create_by!(comment: '清掃が行き届いていて、気持ちよく遊べます。', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '5', safety_star: '5', cost_star: '4', user_id: olivia.id, post_id: posts[4].id)
]

comments.each(&:save)