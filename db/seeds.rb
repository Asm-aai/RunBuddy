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

users = [
  User.find_or_create_by!(email: "lucas@example.com") do |user|
    user.name = "Lucas"
    user.password = "password"
  end,
  User.find_or_create_by!(email: "james@example.com") do |user|
    user.name = "James"
    user.password = "password"
  end,
  User.find_or_create_by!(email: "olivia@example.com") do |user|
    user.name = "Olivia"
    user.password = "password"
  end
  ]



posts = [
  Post.find_or_create_by!(title: 'わんぱくドッグラン 1') do |post|
    post.address = '東京都渋谷区エリア'
    post.hp = 'https://example-dogrun1.com'
    post.introduction = '東京都心にある広々としたドッグラン。大型犬向けエリアや、アジリティ設備も充実しています。'
    post.user_id = User.find_by(email: 'olivia@example.com').id
    post.is_active = true
    post.images.attach([
      {
        io: File.open(Rails.root.join('app', 'assets', 'images', '全力疾走.png')),
        filename: '全力疾走.png'
      },
      {
        io: File.open(Rails.root.join('app', 'assets', 'images', '笑顔.JPG')),
        filename: '笑顔.JPG'
      }
    ])
  end,
  Post.find_or_create_by!(title: 'パピーズドッグパーク') do |post|
    post.address = '神奈川県横浜市エリア'
    post.hp = 'https://example-dogpark2.com'
    post.introduction = '横浜市にある新しいドッグパーク。小型犬向けのエリアが人気で、予約が必要なプールも完備しています。'
    post.user_id = User.find_by(email: 'james@example.com').id
    post.is_active = true
    post.images.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', 'プール.JPG')),
      filename: 'プール.JPG'
    )
  end,
  Post.find_or_create_by!(title: 'グリーンドッグフィールド') do |post|
    post.address = '千葉県千葉市エリア'
    post.hp = 'https://example-dogfield3.com'
    post.introduction = '自然豊かなフィールドで、中型犬向けのエリアも広く確保されています。駐車場完備でアクセスも良好です。'
    post.user_id = User.find_by(email: 'lucas@example.com').id
    post.is_active = true
    post.images.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', 'カフェ.JPG')),
      filename: 'カフェ.JPG'
    )
  end,
  Post.find_or_create_by!(title: 'おしゃれドッグカフェ＆ラン') do |post|
    post.address = '埼玉県川越市エリア'
    post.hp = 'https://example-dogcafe4.com'
    post.introduction = 'ドッグカフェと広いドッグランが併設された施設。トイレやベンチも完備されています。'
    post.user_id = User.find_by(email: 'olivia@example.com').id
    post.is_active = true
    post.images.attach([
      {
        io: File.open(Rails.root.join('app', 'assets', 'images', '洗い場.JPG')),
        filename: '洗い場.JPG'
      },
      {
        io: File.open(Rails.root.join('app', 'assets', 'images', '室内.JPG')),
        filename: '室内.JPG'
      }
    ])

  end,
  Post.find_or_create_by!(title: 'リバーサイドドッグガーデン') do |post|
    post.address = '大阪府大阪市エリア'
    post.hp = 'https://example-doggarden5.com'
    post.introduction = '川沿いにあるドッグガーデンで、広い芝生エリアが特徴です。大型犬向けのエリアもあります。'
    post.user_id = User.find_by(email: 'james@example.com').id
    post.is_active = true
    post.images.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', '里.JPG')),
      filename: '里.JPG'
    )
  end,
  Post.find_or_create_by!(title: 'ヒルサイドドッグパーク') do |post|
    post.address = '京都府京都市エリア'
    post.hp = 'https://example-dogpark6.com'
    post.introduction = '丘の上にあるドッグパークで、エリア分けがされており、どのサイズの犬も楽しめます。'
    post.user_id = User.find_by(email: 'lucas@example.com').id
    post.is_active = true
    post.images.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', '山の上.JPG')),
      filename: '山の上.JPG'
    )
  end,
  Post.find_or_create_by!(title: 'フォレストドッグラン') do |post|
    post.address = '兵庫県神戸市エリア'
    post.hp = 'https://example-dogrun7.com'
    post.introduction = '森林に囲まれた自然豊かなドッグラン。しつけ教室も定期的に開催されています。'
    post.user_id = User.find_by(email: 'olivia@example.com').id
    post.is_active = true
    post.images.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', '雪.JPG')),
      filename: '雪.JPG'
    )
  end,
  Post.find_or_create_by!(title: 'ビーチサイドドッグフィールド') do |post|
    post.address = '神奈川県鎌倉市エリア'
    post.hp = 'https://example-dogfield8.com'
    post.introduction = 'ビーチに近いドッグフィールドで、海岸沿いの散歩も楽しめます。プール施設も完備。'
    post.user_id = User.find_by(email: 'james@example.com').id
    post.is_active = true
    post.images.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', '川.JPG')),
      filename: '川.JPG'
    )
  end,
]

tags = [
  { name: '大型犬向け', english_word: 'large dog/big dog/for large dogs' },
  { name: '中型犬向け', english_word: 'medium dog/for medium dogs' },
  { name: '小型犬向け', english_word: 'small dog/for small dogs' },
  { name: '駐車場完備', english_word: 'parking/parking available/car park' },
  { name: '公共交通機関でアクセス可能', english_word: 'public transport/accessible by public transport/transit' },
  { name: 'トイレ完備', english_word: 'toilets, restroom/bathroom available' },
  { name: 'ベンチあり', english_word: 'bench/eating/bench available' },
  { name: 'ゴミ箱設置', english_word: 'trash can/garbage/waste bin' },
  { name: '予約必要', english_word: 'reservation required/booking, reserve' },
  { name: 'しつけ教室あり', english_word: 'training class/obedience school' },
  { name: 'ドッグカフェあり', english_word: 'shop/cafe' },
  { name: 'エリア分けあり', english_word: 'area division/separate area/partitioned area' },
  { name: 'プールあり', english_word: 'pool/swimming pool/water pool' },
  { name: 'アジリティ設備あり', english_word: 'agility equipment/obstacle course/agility course' }
]

tags.each do |tag|
  Tag.find_or_create_by!(name: tag[:name]) do |t|
    t.english_word = tag[:english_word]
  end
end

posts.each do |post|
  random_tags = tags.sample(rand(5..7))
  post.tags = random_tags.map { |tag_data| Tag.find_or_create_by!(name: tag_data[:name]) do |t|
    t.english_word = tag_data[:english_word]
  end }
end

comments = [
  Comment.find_or_create_by!(comment: 'とても良いドッグランでした！また来たいです。', total_star: '5', extent_star: '4', clean_star: '5', amenity_star: '3', safety_star: '4', cost_star: '3', user_id: '1', post_id: '1'),
  Comment.find_or_create_by!(comment: 'スタッフが親切で、安心して遊ばせられました。', total_star: '4', extent_star: '3', clean_star: '4', amenity_star: '5', safety_star: '4', cost_star: '3', user_id: '2', post_id: '1'),
  Comment.find_or_create_by!(comment: '設備が整っていて、犬も楽しんでいました。', total_star: '5', extent_star: '5', clean_star: '4', amenity_star: '3', safety_star: '5', cost_star: '3', user_id: '3', post_id: '1'),
  Comment.find_or_create_by!(comment: '混雑していましたが、楽しめました！', total_star: '3', extent_star: '2', clean_star: '4', amenity_star: '3', safety_star: '3', cost_star: '5', user_id: '1', post_id: '2'),
  Comment.find_or_create_by!(comment: 'ドッグカフェの食べ物が美味しかったです！', total_star: '5', extent_star: '4', clean_star: '4', amenity_star: '5', safety_star: '5', cost_star: '4', user_id: '2', post_id: '2'),
  Comment.find_or_create_by!(comment: '大型犬も安心して遊べました。', total_star: '4', extent_star: '3', clean_star: '5', amenity_star: '4', safety_star: '4', cost_star: '3', user_id: '3', post_id: '2'),
  Comment.find_or_create_by!(comment: 'もっと広いエリアがあれば嬉しいです。', total_star: '3', extent_star: '3', clean_star: '3', amenity_star: '2', safety_star: '3', cost_star: '4', user_id: '1', post_id: '3'),
  Comment.find_or_create_by!(comment: 'トイレがきれいで、便利でした。', total_star: '5', extent_star: '4', clean_star: '5', amenity_star: '5', safety_star: '4', cost_star: '3', user_id: '2', post_id: '3'),
  Comment.find_or_create_by!(comment: '犬が自由に遊べて嬉しいです。', total_star: '4', extent_star: '3', clean_star: '4', amenity_star: '4', safety_star: '4', cost_star: '5', user_id: '3', post_id: '3'),
  Comment.find_or_create_by!(comment: '大きなプールがあって、犬が楽しそうでした。', total_star: '5', extent_star: '4', clean_star: '3', amenity_star: '4', safety_star: '5', cost_star: '3', user_id: '1', post_id: '4'),
  Comment.find_or_create_by!(comment: 'しつけ教室があって、とても役立ちました。', total_star: '4', extent_star: '3', clean_star: '3', amenity_star: '4', safety_star: '5', cost_star: '4', user_id: '2', post_id: '4'),
  Comment.find_or_create_by!(comment: '料金が少し高めですが、価値があります。', total_star: '3', extent_star: '4', clean_star: '4', amenity_star: '3', safety_star: '3', cost_star: '3', user_id: '3', post_id: '4'),
  Comment.find_or_create_by!(comment: 'エリア分けがあり、安心して遊ばせられます。', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '4', safety_star: '4', cost_star: '3', user_id: '1', post_id: '5'),
  Comment.find_or_create_by!(comment: 'ベンチがたくさんあり、休憩しやすかったです。', total_star: '4', extent_star: '4', clean_star: '3', amenity_star: '5', safety_star: '3', cost_star: '4', user_id: '2', post_id: '5'),
  Comment.find_or_create_by!(comment: 'ゴミ箱が設置されていて、環境が良いです。', total_star: '4', extent_star: '4', clean_star: '5', amenity_star: '4', safety_star: '4', cost_star: '3', user_id: '3', post_id: '5'),
  Comment.find_or_create_by!(comment: '予約が必要ですが、スムーズに入れました。', total_star: '4', extent_star: '4', clean_star: '3', amenity_star: '3', safety_star: '3', cost_star: '3', user_id: '1', post_id: '6'),
  Comment.find_or_create_by!(comment: '犬が遊ぶのにとても良い場所です！', total_star: '5', extent_star: '5', clean_star: '5', amenity_star: '4', safety_star: '4', cost_star: '4', user_id: '2', post_id: '6'),
  Comment.find_or_create_by!(comment: '中型犬向けに最適でした。', total_star: '4', extent_star: '3', clean_star: '4', amenity_star: '3', safety_star: '4', cost_star: '3', user_id: '3', post_id: '6'),
  Comment.find_or_create_by!(comment: '遊び場が充実していて、犬が楽しんでいました。', total_star: '5', extent_star: '4', clean_star: '4', amenity_star: '4', safety_star: '5', cost_star: '3', user_id: '1', post_id: '7'),
  Comment.find_or_create_by!(comment: 'スタッフの対応がとても良かったです。', total_star: '5', extent_star: '4', clean_star: '5', amenity_star: '5', safety_star: '4', cost_star: '4', user_id: '2', post_id: '7'),
  Comment.find_or_create_by!(comment: 'ドッグカフェも利用しましたが、味も良かったです。', total_star: '4', extent_star: '3', clean_star: '4', amenity_star: '3', safety_star: '4', cost_star: '3', user_id: '3', post_id: '7'),
  Comment.find_or_create_by!(comment: '安全に遊べるエリアがあって安心しました。', total_star: '4', extent_star: '4', clean_star: '3', amenity_star: '4', safety_star: '5', cost_star: '3', user_id: '1', post_id: '8'),
  Comment.find_or_create_by!(comment: '子供連れでも楽しめる場所です。', total_star: '4', extent_star: '3', clean_star: '3', amenity_star: '4', safety_star: '4', cost_star: '3', user_id: '2', post_id: '8'),
  Comment.find_or_create_by!(comment: '遊ぶ場所が広く、犬が満足していました。', total_star: '5', extent_star: '5', clean_star: '4', amenity_star: '4', safety_star: '5', cost_star: '3', user_id: '3', post_id: '8'),
  Comment.find_or_create_by!(comment: '日陰があって、夏でも快適に過ごせました。', total_star: '4', extent_star: '3', clean_star: '4', amenity_star: '5', safety_star: '4', cost_star: '3', user_id: '1', post_id: '8')
]

comments.each(&:save)