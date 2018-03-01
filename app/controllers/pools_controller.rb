class PoolsController < ApplicationController
  before_action :set_pool, only: [:show, :edit, :update, :destroy]

  def index
    @pools = Pool.all.page params[:page]
  end

  def show
    @posts = @pool.posts.page params[:page]
  end

  def new
    @pool = Pool.new
  end

  def create
    @pool = Pool.create(name: pool_params[:name])
    @pool.user = cureent_user
    pool_params[:posts_string].split(" ").each do |post_id|
      next unless Post.exists?(post_id)
      post = Post.find(post_id)
      @pool.posts << post
    end
    redirect_to pool_url(@pool)
  end

  def update

  end

  def destroy
    @pool.destroy
    redirect_to pools_url
  end

  private
  def pool_params
    params.require(:pool).permit(:name, :posts_string)
  end

  def set_pool
    @pool = Pool.find(params[:id])
  end
end
