
def gimme_images
	Dir.glob("../**/*")
end
Dir.glob("../app/assets/images/posts/**/*").each do |image|
	#Post.create(name: File.basename(image).to_s) unless File.directrory?(image)
	puts File.basename(image)
	puts File.basename(image).class
	#Post.save
	#puts image
end