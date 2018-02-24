class PostQueryBuilder
  def initialize
    @scope = Post.all
  end
  def build_query(params)
    scope = filter_by_tags(@scope, params[:tags])
    scope = filter_by_page(scope, params[:page])
    scope = filter_by_user(scope, params[:user])
    scope.order(:id).reverse_order
  end
  def filter_by_page(scope, page = 0)
    scope = scope.page page
  end
  def filter_by_user(scope, user = nil)
    return scope unless user
    user = User.find_by(username: user) 
    user ? scope.where(user_id: user.id) : scope
  end
  def filter_by_tags(scope, tags_string = nil)
    tags = get_tags(tags_string)
    return scope unless tags
    tags, aliases_count = add_aliases_to(tags)
    #puts tags.count, aliases_count
    general_count = 
              if tags.count == aliases_count
                1
              else
                tags.count-aliases_count
              end
    scope
        .joins(:tags)
        .where(tags: {name: tags})
        .group('posts.id')
        .having('count(*) = ?', general_count)
  end
  def add_aliases_to(tags)
    new_tags = Array.new
    aliases_count = 0
    tags.each do |tag_name|
      new_tags << tag_name
      tag = Tag.find_by(name: tag_name)
      next unless tag
      if tag.aliases.any?
        tag.aliases.each do |ali|
          new_tags << ali.name unless new_tags.include? ali.name
          aliases_count += 1
        end
      else
        new_tag = Tag.joins(:tag_aliases).where(tag_aliases: {alias_id: tag.id})
        next unless new_tag.first
        new_tags << new_tag.first.name
        aliases_count += 1
        new_tag.first.aliases.each do |ali|
          new_tags << ali.name unless new_tags.include? ali.name
          aliases_count += 1
        end
      end
    end
    return new_tags, aliases_count
  end
  def get_alias(tag)
    #tag = Tag.find_by(name: tag_name)
    return unless tag
    tag_alias = TagAlias.find_by(alias_id: tag.id)# if tag
    return unless tag_alias
    Tag.find(tag_alias.tag_id)
  end
  def get_tags(tags_string)
    tags_string ? tags_string.split(" ").uniq : nil
  end
end
