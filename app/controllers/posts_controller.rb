class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :get_tag_array, only: [:create, :update]

  before_action :set_limit, only: [:index]
  before_action :set_page, only: [:index]
  before_action :set_tags, only: [:index]

  before_action :get_memory

  rescue_from ActiveRecord::RecordNotFound, with: :invalid_post
  # GET /posts
  # GET /posts.json
  def index
    #@posts = Post.order(:id).reverse_order

    #@posts = Post.order(:id).reverse_order.offset(@offset).limit(@limit)
    #query = "select * from posts p where not EXISTS (select * from tags t where name in ('#{@tags}') and not EXISTS (select * from Posts_Tags pt WHERE pt.post_id = p.id AND pt.tag_id = t.id))"


    unless @tags
      @posts = Post.order(:id).reverse_order.offset(@offset).limit(@limit)
      unless @limit == 0
        @pages_count = (Post.count/@limit).to_i+1
      end
    else
      query = %{  SELECT *
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
      count_query = %{  SELECT count(*)
                    FROM posts p
                    WHERE NOT EXISTS (SELECT * FROM Tags t
                          WHERE name IN ('#{@tags}')
                                AND NOT EXISTS
                                          (SELECT * FROM Posts_Tags pt
                                           WHERE pt.post_id = p.id
                                           AND pt.tag_id = t.id))
                                            }

      @posts = Post.find_by_sql(query)
      #posts_count = Post.find_by_sql(count_query
      unless @limit == 0
        @pages_count = 50 #(posts_count.count/@limit).to_i+1
      end   
    end
    #@posts = Post.order(:id).reverse_order.offset(@offset).limit(@limit)

    #redirect_to gallery_index_url #if @posts.count == 0

      #@uniq_tags = Tag.joins(:posts).where(post_id: @posts.map{|p| p.id})
      tag_quiery = %{
        select tags.name, tags.id from tags
        inner join posts_tags on tags.id = posts_tags.tag_id
        where posts_tags.post_id in (#{@posts.map {|p| p.id}.join(", ")}) group by tags.name, tags.id
      }
      @uniq_tags = Tag.find_by_sql(tag_quiery)#.map{|t| t.name}.uniq
      #@uniq_tags = Tag.joins(:posts).where('posts_tags.post_id' => @posts.map{|p| p.id})
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @tags_array = @post.tags.map {|tag| tag.name}
    puts @tags_array
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    #add_tags(@tags)
    Tag.add_tags(@tags)
    @post.add_tags(@tags)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    Tag.add_tags(@tags)
    @post.add_tags(@tags)
    #add_tags(@tags)
    @post.remove_tags(@tags)
    #remove_tags(@tags)

=begin
    #adding tags
    tags.each do |tag|
      tag = Tag.where(name: tag).first
      if tag
        @post.tags << tag unless @post.tags.include? tag
      end
    end

    #removing tags
    @post.tags.each do |tag|
      @post.tags.delete(tag) unless tags.include? tag.name
    end
=end
    #@post.tags << Tag.find(params[:post][:tag_id])
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def get_memory
      mem = GetProcessMem.new
      puts mem.inspect
    end

    def add_tags(tags)
      tags.each do |tag|
        tag = Tag.where(name: tag).first
        if tag
          @post.tags << tag unless @post.tags.include? tag
        end
      end
    end

    def remove_tags(tags)
      @post.tags.each do |tag|
        @post.tags.delete(tag) unless tags.include? tag.name
      end
    end

    def get_tag_array
      @tags = params[:post][:tags_array].split(" ")
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:path, :name, :image)
    end

    def invalid_post
      logger.error "attempt to acces invalid post #{params[:id]}"
      redirect_to gallery_index_url
    end


    def set_limit
      if params[:limit]
        #session[:limit] = params[:limit].to_i
        @limit = params[:limit].to_i
      else
        @limit = 20
      end
    end

    def set_page
      if params[:page]
        @page = params[:page]
        #session[:page] = params[:page]
        @offset = @limit * params[:page].to_i
        #session[:page] = session[:limit] * session[:page].to_i
      else
        @offset = 0
      end
    end

    def set_tags
      if params[:tag]
        @tags = params[:tag].split(" ").join("', '")
        @tags_string = params[:tag]
        #@tag = tags_array.map {|t| Tag.where(name: t)}
      else
        @tags = false
      end
    end
end
