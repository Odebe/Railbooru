class PanelController < ApplicationController

  before_action :check_admin

  def index
    @posts = Post.where(status: :pending)
    #@aliases = TagAlias.all
  end

  def posts
    @posts = Post.where(status: :pending).page params[:page]
  end

  def deleted_posts
    
  end

  private

    def check_admin
      if current_user.nil? || !current_user.admin_role?
        redirect_to :root, alert: "За вами уже выехали"
      end
    end
end
