class CommentsController < ApplicationController
  def create
    @post = Post.find_by id: params[:comment][:post_id]
    @comment = Comment.find_by id: params[:comment][:comment_parent_id]
    if @comment.nil?
      @comment_parent = Comment.new comment_params
      @comment_parent.user_id = current_user.id
      if @comment_parent.save
        render json: {status: :success, html: render_to_string(@comment_parent)}
      else
        render json: {status: :fail}
      end
    else
      @comment_child = Comment.new comment_params
      @comment_child.user_id = current_user.id

      if @comment_child.save
          render json: {status: :success, html: render_to_string(@comment_child)}
      end
    end
  end

  def show

  end

  def destroy
    @comment = Comment.find_by id: params[:id]

    if @comment.destroy
      render json: {status: :success}
    else
      render json: {status: :error}
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :comment_parent_id, :post_id
  end
end
