class PostService

  def initialize(user, params)
    puts params
    @params = params
    if params[:post]
      @post_params = params.require(:post).permit(:path, :name, :image, :rating)
      @tags_array = params.require(:post)[:tags_string].split(" ")
      @tags_string = params.require(:post)[:tags_string]
    end
    @user = user

    @tag_service = TagService.new
=begin
      if params[:id]
        @post = Post.find(params[:id])
      else
        @post = Post.create(post_params)
        @user.posts << @post
      end
=end
    #@errors = @post.errors
    #@post.errors.clear
    #@post.update(rating: post_params[:rating])
    #user.posts << @post
    #update_tags(tags_array)
  end

  def destroy_post
    post = Post.find(@params[:id])
    tags = post.tags
    @tag_service.decrease_tag_counts_of(post)
    post.destroy
    #decrease_counts_for(tags)
    #tags.each do |tag|
    #  tag.update(posts_count: tag.posts_count-1)
    #end
    #post.destroy
  end

  def create_post
    #@post = Post.create(@post_params)
    post = @user.posts.build(@post_params)
    #@user.posts << @post
    set_errors_for(post)
    if post.valid?
      post.save
      @tag_service.update_tags(@tags_array, post)
    end
  end

  def update_post
    #return nil unless @post_params[:id]
    post = Post.find(@params[:id])
    post.update(@post_params)
    set_errors_for(post)
    @tag_service.update_tags(@tags_array, post)
    #update_tags(@tags_array)
    #@tags_array
  end

  def set_errors_for(post)
    @errors = post.errors
    #post.errors.clear
  end


  def save?
    true
  end

  def errors
    @errors.full_messages
  end

  def clear_errors
    @post.errors.clear
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