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
    @posts = PostQueryBuilder.new.build_query(params)
    @tags = Tag.joins(:posts).where(posts: {id: @posts.ids}).limit(25).group([:id,:name]).order(:name)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @tags = @post.tags
    respond_to :html, :js
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
      if post_service.save?
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to new_post_url, alert: post_service.errors }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    post_service = PostService.new(current_user, params)

    respond_to do |format|
      if post_service.save?
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { redirect_to :edit, alert: post_service.errors }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    PostService.destroy(@post)
    #@post.destroy
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
      params.require(:post).permit(:path, :name, :image, :rating)
    end

    def invalid_post
      logger.error "attempt to acces invalid post #{params[:id]}"
      redirect_to gallery_index_url
    end


    def set_limit
      @limit = params[:limit].to_i if params[:limit]
    end

    def get_tags
      @tags = 
        if params[:tag]
          params[:tag].split(" ").uniq
        else
          Array.new
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