class GalleryController < ApplicationController

	before_action :set_limit, only: [:index]
	before_action :set_page, only: [:index]
	before_action :set_tags, only: [:index]



  def index

  	#@posts = Post.order(:id).reverse_order.offset(@offset).limit(@limit)
  	unless @tags
  		@posts = Post.order(:id).reverse_order.offset(@offset).limit(@limit)
  		unless @limit == 0
  			@pages_count = (Post.count/@limit).to_i+1
  		end
  	else
			query = %{	SELECT *
										FROM posts p
										WHERE NOT EXISTS (SELECT * FROM Tags t
										      WHERE name IN ('#{@tags}')
										            AND NOT EXISTS
										                      (SELECT * FROM Posts_Tags pt
										                       WHERE pt.post_id = p.id
										                       AND pt.tag_id = t.id))
										                       	 limit #{@limit}
											                       offset #{@offset}
										                       	}
	  	@posts = Post.find_by_sql(query)
	  	#posts_count = Post.find_by_sql(count_query
			unless @limit == 0
	  		@pages_count = 50 #(posts_count.count/@limit).to_i+1
  		end	  
	  end

  	#redirect_to gallery_index_url #if @posts.count == 0
	  	tag_quiery = %{
	  		select tags.name, tags.id from tags
	  		inner join posts_tags on tags.id = posts_tags.tag_id
	  		where posts_tags.post_id in (#{@posts.map {|p| p.id}.join(", ")}) group by tags.name, tags.id
	  	}
	  	@uniq_tags = Tag.find_by_sql(tag_quiery)#.map{|t| t.name}.uniq
	  	#@uniq_tags = Tag.joins(:posts).where('posts_tags.post_id' => @posts.map{|p| p.id})
 	end

  private

	  def set_limit
	  	if params[:limit]
	  		@limit = params[:limit].to_i
	  	else
	  		@limit = 20
	  	end
	  end

	  def set_page
	  	if params[:page]
	  		@page = params[:page]
	  		@offset = @limit * params[:page].to_i
	  	else
	  		@offset = 0
	  	end
	  end

	  def set_tags
	  	if params[:tag]
	  		@tags = params[:tag].split(" ").join("', '")
	  		@tags_string = params[:tag]
	  	else
	  		@tags = false
	  	end
	  end


end

=begin
SELECT *
FROM posts p
WHERE NOT EXISTS (SELECT * FROM Tags t
                  WHERE name IN ('lain')
                  AND NOT EXISTS
                      (SELECT * FROM Posts_Tags pt
                       WHERE pt.post_id = p.id
                       AND pt.tag_id = t.id))

select tags.*
	from tags
		inner join posts_tags on tags.id = posts_tags.tag_id
			where posts_tags.post_id
				in (1613, 1678) 

=end

