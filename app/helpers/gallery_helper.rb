module GalleryHelper

	def print_uniq_tags(posts)
		posts.map {|p| p.tags }.flatten.uniq.each do |tag|
      link_to tag.name, gallery_index_url(tag: tag.name)
      content_tag(:br)
    end
	end

	def image_row(posts)
		posts.each_slice(5) do |posts|
			yield(posts)
		end
	end
end
