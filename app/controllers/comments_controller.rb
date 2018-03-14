class CommentsController < ApplicationController
  load_and_authorize_resource :nested => :post

	before_action :set_comment, only: [:destroy]
	before_action :set_post, only: [:destroy]
	def new
		#@post = Post.find(params[:post_id])
	end

	def create
		@post = Post.find(params[:post_id])
    @post.comments.create(comment_params) do |comment|
      comment.user = current_user
      comment.save
    end
		redirect_to post_path(@post)
	end

	def destroy
    #authorize! :destroy, @comment, message: "Unable to destroy this comment."
		@comment.delete
		redirect_to post_url(@post)
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end

	def set_comment
		@comment = Comment.find(params[:id])
	end

	def set_post
		@post = @comment.post
	end
end
