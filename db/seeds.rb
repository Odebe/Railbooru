# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
#require "migr.rb"

path = "app/assets/images/posts"
Post.delete_all
Tag.delete_all

tags = ["lain", "popteamepic", "oekakiwin", "va-11_hall-a", "dana", "dorothy", "smug", "best_boss"]
#Post.get_images_from_folder(path)

tags.each do |tag|
	t = Tag.new
	t.name = tag
	t.save
end
=begin
Dir.glob("app/assets/images/posts/*").each do |image|
	iname = File.basename(image)
	Post.create(name: iname, path: "posts/#{iname}") unless File.directory?(image)
end
=end
Dir.glob("#{path}/*").each do |image|
	unless File.directory?(image)
		post = Post.create!(name: File.basename(image))
		post.image = Rails.root.join(image).open
		post.save!
	end
	#Post.create(name: iname, path: "posts/#{iname}", thumbnail: "#{thumbnail}" ) unless File.directory?(image)
end
