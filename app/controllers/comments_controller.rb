class CommentsController < ApplicationController
    before_action :authenticate_request

    def index 
        @comments = Comment.all 
        render json: @comments
    end

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params.merge(user: @current_user))

        if @comment.save
            render json: @comment, status: :created
        else
            render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:description)
    end
end
