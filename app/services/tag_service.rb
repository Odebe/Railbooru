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

  def get_aliases_for(tags)
    aliases = []
    tags.each do |tag_name|
      tag = Tag.find_by(name: tag_name)
      next unless tag
      puts tag.name
      puts "#{tag.aliases}"
      puts tag.inverse_aliases
      aliases << tag.aliases
      #aliases << tag.inverse_aliases
      next unless tag.inverse_aliases.any?
      aliases << tag.inverse_aliases
      tag.inverse_aliases.each do |inv|
        aliases << inv.aliases
      end
=begin
              if tag.aliases.count > 1
                tag.aliases
              else
                #inv = tag.inverse_aliases
                #inv << get_aliases_for(inv.map(&:name))
                tag.inverse_aliases
              end
=end
    end
    aliases.uniq.flatten!
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