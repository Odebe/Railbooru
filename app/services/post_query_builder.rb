class PostQueryBuilder
  def initialize
    @scope = Post.all
  end
  def build_query(params)
    scope = filter_by_tags(@scope, params[:tags])
    scope = filter_by_page(scope, params[:page])
    scope = filter_by_user(scope, params[:user])
    scope = filter_by_rating(scope, params[:rating])
    scope = filter_by_status(scope, params[:status])
    scope.order(:id).reverse_order
  end
  def filter_by_page(scope, page = 0)
    scope = scope.page page
  end
  def filter_by_status(scope, status = :published)
    return scope if status == :published
    scope = scope.where(status: [:published, status])
  end
  def filter_by_user(scope, user = nil)
    return scope unless user
    user = User.find_by(username: user) 
    user ? scope.where(user_id: user.id) : scope
  end
  def filter_by_rating(scope, rating = nil)
    return scope unless rating
    scope.where(rating: rating)
  end
  def filter_by_tags(scope, tags_string = nil)
    tags = get_tags(tags_string)
    return scope unless tags
    tag_service = TagService.new
    aliases = tag_service.get_aliases_for(tags)
    aliases.each do |a|
      tags << a.name
    end
    scope
        .joins(:tags)
        .where(tags: {name: tags})
        .group('posts.id')
        .having('count(*) = ?', tags.count-aliases.count)
  end
=begin
  def add_aliases_to(tags)
    new_tags = Array.new
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
=end
  def get_alias(tag)
    return unless tag
    tag_alias = TagAlias.find_by(alias_id: tag.id)# if tag
    return unless tag_alias
    Tag.find(tag_alias.tag_id)
  end
  def get_tags(tags_string)
    tags_string ? tags_string.split(" ").uniq : nil
  end
end
