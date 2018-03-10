class TagService

  def initialize#(tag_string)
    #@tags_names_array = tag_string.split(" ") 
  end

  def update_tags(tags_array, post)
    create_new_tags(tags_array)
    add_tags_to_post(tags_array, post)
    remove_tags_from_post(tags_array, post)
  end

  def tag_names_array(tags)
    tag_string.split(" ") 
  end

  def get_array_with_aliases_for(tags)
    new_tags = Array.new

    tags.each do |tag_name|
      tag = Tag.find_by(name: tag_name)
      next unless tag
      
    end


    aliases_count = 0
    tags.each do |tag_name|
      new_tags << tag_name
      tag = Tag.find_by(name: tag_name)
      next unless tag
      aliases =
          if tag.aliases.any?
            tag.aliases
          else
            new_tag = Tag.joins(:tag_aliases)
                         .where(tag_aliases: {alias_id: tag.id}).first
            next unless new_tag
            new_tags << new_tag.name
            #aliases_count += 1
            new_tag.aliases
          end
      aliases.each do |ali|
        new_tags << ali.name unless new_tags.include? ali.name
        aliases_count += 1
      end
    end
    return new_tags, aliases_count
  end

  def decrease_tag_counts_of(post)
    post.tags.each do |tag|
      tag.update(posts_count: tag.posts_count-1)
    end
  end

  def create_new_tags(tags)
    tags = tag_names_array(tags) if tags.kind_of? String
    tags.each do |tag|
      Tag.find_or_create_by(name: tag)
    end
  end

  def add_tags_to_post(tags, post)
    tags = tag_names_array(tags) if tags.kind_of? String
    tags.each do |tag|
      tag = Tag.where(name: tag).first
      next unless tag #Tag.exists?(name: tag) #tag
      next if post.tags.include? tag
      post.tags << tag 
      tag.update(posts_count: tag.posts_count+1)
    end
  end
  
  def remove_tags_from_post(tags_array, post)
    post.tags.each do |tag|
      next if tags_array.include? tag.name
      post.tags.destroy(tag)
      tag.update(posts_count: tag.posts_count-1)
    end
  end
end