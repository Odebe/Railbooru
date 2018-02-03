class TagsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_tag, only: [:show, :edit, :destroy, :update]

  rescue_from ActiveRecord::RecordNotFound, with: :invalid_tag

  def index
    @tags = Tag.all.reverse
  end

  def show
    @posts = @tag.posts.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html {redirect_to tags_index_url}
      else
        format.html {redirect_to tags_index_url notide: "wrong argiments"}
      end
    end
  end

  def destroy
    @tag.destroy
    respond_to do |format|
      format.html {redirect_to tags_index_url}
    end
  end

  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html {redirect_to tags_index_url}
      else
        format.html {redirect_to tags_index_url notide: "wrong argiments"}
      end
    end
  end

  private

    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:name)
    end

    def invalid_tag
      redirect_to tags_index_url
    end

end
