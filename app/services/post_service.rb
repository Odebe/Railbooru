class PostService

  def initialize(user, params)
    @user = user
    @params = params
    @post_params = params.require(:post).permit(:path, :name, :image)
    @tags_array = params[:post][:tags_string].split(" ")
  end

  def create
    @post = @user.posts.create(@post_params)
    update_tags
  end

  def update
    @post = Post.find(@params[:id])
    @post.update(@post_params)
    update_tags
  end

  def save
    return @post
  end

  private

  def update_tags
    create_new_tags
    add_tags_to_post
    remove_tags_from_post
  end

  def create_new_tags
    @tags_array.each do |tag|
      Tag.create(name: tag) if Tag.where(name: tag).count == 0
    end
  end


  def add_tags_to_post
    @tags_array.each do |tag|
      tag = Tag.where(name: tag).first
      if tag
        @post.tags << tag unless @post.tags.include? tag
      end
    end
  end

  def remove_tags_from_post
    @post.tags.each do |tag|
      @post.tags.delete(tag) unless @tags_array.include? tag.name
    end
  end

end