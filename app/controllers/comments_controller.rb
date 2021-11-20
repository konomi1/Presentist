class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_present

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.present_id = @present.id
    if @comment.save
      render :comment
    else
      render :errors
    end
  end

  def destroy
    comment = @present.comments.find(params[:id])
    comment.destroy
    render :comment
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

  def set_present
    @present = Present.find(params[:present_id])
  end
end
