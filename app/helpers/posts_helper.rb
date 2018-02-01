module PostsHelper

	def post_show_image(post)
		if post.has_sample?
			yield(post.image.sample)
		else
			yield(post.image)
		end
	end
end
