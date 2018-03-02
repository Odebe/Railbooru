class TagAliasesController < ApplicationController
  #before_action :tag_alias_params

  def index
    @aliases = TagAlias.page(params[:page]).per(12)
  end

  def new
    @alias = TagAlias.new
  end

  def create
    tag_alias = Tag.find_by(name: tag_alias_params[:from])
    tag = Tag.find_by(name: tag_alias_params[:to])
    if tag && tag_alias
      tag.aliases << tag_alias
    end
    redirect_to :index
  end

  def destroy

  end

  private

  def tag_alias_params
    params.require(:tag_alias).permit(:from, :to)
  end

end
