module PostsHelper
  def tag_string_for(post)
    post.tags.map{|t| t.name}.join(" ")
  end

  def link_to_image(post)
    post.samp ? post.image.sample : post.image
  end
end
