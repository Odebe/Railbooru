class PostService

  def initialize(user, params)
    post_params = params.require(:post).permit(:path, :name, :image)
    tags_array = params[:post][:tags_string].split(" ")

    @post =
      if params[:id]
        Post.find(params[:id])
      else
        Post.create(post_params)
      end

    user.posts << @post
    update_tags(tags_array)
  end

  def save
    @post
  end

  private

  def update_tags(tags_array)
    create_new_tags(tags_array)
    add_tags_to_post(tags_array)
    remove_tags_from_post(tags_array)
  end

  def create_new_tags(tags_array)
    tags_array.each do |tag|
      Tag.find_or_create_by(name: tag)
    end
  end

  def add_tags_to_post(tags_array)
    tags_array.each do |tag|
      tag = Tag.where(name: tag).first
      if tag
        #tag.posts << @post unless @post.tags.include? tag
        unless @post.tags.include? tag
          #tag.posts << @post
          @post.tags << tag 
          tag.update(posts_count: tag.posts_count+1)
        end
      end
    end
  end
  
  def remove_tags_from_post(tags_array)
    @post.tags.each do |tag|
      unless tags_array.include? tag.name
        @post.tags.destroy(tag)
        tag.update(posts_count: tag.posts_count-1)
      end
    end
  end
end