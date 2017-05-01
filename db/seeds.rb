require 'csv'
media_file = Rails.root.join('db', 'media_seeds.csv')

CSV.foreach(media_file, headers: true, header_converters: :symbol, converters: :all) do |row|
  data = Hash[row.headers.zip(row.fields)]
  puts data
  Work.create!(data)
end


User.create ([
  {
    username: "Stanley",
    uid: "111",
    provider: "github",
    email: "whatevs@whatevah.com"
  }
  ])

Work.create ([
  {
    title: "It's a Wonderful Life",
    creator: "Frank Capra",
    description: "suicidal man comforted by underperforming angel",
    category: "movie",
    publication_year: 1946,
    user: User.first
  }
  ])
