# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Message.create(content: "Ruby is the best programming language", status: Message::RELEVANT)
Message.create(content: "No Python is much better and easier to understand", status: Message::RELEVANT)
Message.create(content: "How much wood could a wood chuck chuck if a wood chuck could chuck wood?", status: Message::RELEVANT)
Message.create(content: "Visit XYZ 13 for the latest news stories", status: Message::RELEVANT)
Message.create(content: "Check out our family vacation photos on Facebook", status: Message::RELEVANT)

Message.create(content: "Make tons and tons of money in casinos", status: Message::SPAM)
Message.create(content: "Go to my website to see hundreds of pharmaceuticals at steep discounts", status: Message::SPAM)
Message.create(content: "We are SEO wizards. Use us and your site traffic will increase 200 percent" , status: Message::SPAM)
Message.create(content: "Fill out a few surveys and receive a free iPad. This is for real.", status: Message::SPAM)
Message.create(content: "Having PC trouble? Download PC Enhancer and your PC woes will disappear!", status: Message::SPAM)
