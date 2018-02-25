class PostQueryBuilder
  def initialize
    @scope = Post.all
  end
  def build_query(params)
    scope = filter_by_tags(@scope, params[:tags])
    scope = filter_by_page(scope, params[:page])
    scope = filter_by_user(scope, params[:user])
    scope = filter_by_rating(scope, params[:rating])
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
  def filter_by_rating(scope, rating = nil)
    return scope unless rating
    scope.where(rating: rating)
  end
  def filter_by_tags(scope, tags_string = nil)
    tags = get_tags(tags_string)
    return scope unless tags
    scope
        .joins(:tags)
        .where(tags: {name: tags})
        .group('posts.id')
        .having('count(*) = ?', tags.count)
  end
  def get_tags(tags_string)
    tags_string ? tags_string.split(" ").uniq : nil
  end
end
