# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "twitter"

Message.find_each do |message|
  message.destroy
end

Twitter.search("#java -rt", :rpp => 100, :lang => "en").each do |tweet|
  Message.create(content: tweet.text, status: Message::RELEVANT)
end
