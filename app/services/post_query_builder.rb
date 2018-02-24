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
    tags, aliases_count = filter_by_aliases(tags)
    scope
        .joins(:tags)
        .where(tags: {name: tags})
        .group('posts.id')
        .having('count(*) = ?', tags.count-aliases_count)
  end
  def filter_by_aliases(tags)
    return unless tags
    aliases_count = 0
    tags.map do |tag_name|
      new_name = get_alias(tag_name)
      next unless new_name
      tags << new_name
      aliases_count += 1
    end
    return tags, aliases_count
  end
  def get_alias(tag_name)
    tag = Tag.find_by(name: tag_name)
    return unless tag
    tag_alias = TagAlias.find_by(alias_id: tag.id)# if tag
    return unless tag_alias
    Tag.find(tag_alias.tag_id).name 
  end
  def get_tags(tags_string)
    tags_string ? tags_string.split(" ").uniq : nil
  end
end
