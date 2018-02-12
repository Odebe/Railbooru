class PostsController < ApplicationController
  load_and_authorize_resource 

  before_action :set_post, only: [:show, :edit, :update, :destroy]
  #before_action :get_tag_array, only: [:create, :update]

  #before_action :set_tag_string, only: [:update, edit]

  before_action :set_limit, only: [:index]
  before_action :get_tags, only: [:index]

  before_action :get_memory

  rescue_from ActiveRecord::RecordNotFound, with: :invalid_post

  # GET /posts
  # GET /posts.json
  def index
    @posts =
      unless @tags.any?
        Post.order(:id).reverse_order.page params[:page]
      else
        Post.joins(:tags).where(tags: {name: @tags}).group('posts.id').having('count(*) = ?', @tags.count).order(:id).reverse_order.page params[:page] 
      end
    @tags = Tag.joins(:posts).where(posts: {id: @posts.ids}).limit(25).group([:id,:name]).order(:name)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @tags = @post.tags
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    #@tags_array = @post.tags.map {|tag| tag.name}
    @tags_array = Tag.select(:name).joins(:posts).where(posts: {id: @post.id})
    #@post.tags
  end

  # POST /posts
  # POST /posts.json
  def create
    post_service = PostService.new(current_user, params)
    
    respond_to do |format|
      if post_service.save
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
    post_service = PostService.new(current_user, params)

    respond_to do |format|
      if post_service.save
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
        @limit = params[:limit].to_i
      else
        @limit = 20
      end
    end

    def get_tags
      @tags = Array.new
      if params[:tag]
        params[:tag].split(" ").each do |t|
          @tags << t
        end
      end
    end

end

=begin
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

tag_query = %{
        select tags.name, tags.id from tags
        inner join posts_tags on tags.id = posts_tags.tag_id
        where posts_tags.post_id in (#{@posts.map {|p| p.id}.join(", ")}) group by tags.name, tags.id
      }
=end                                            