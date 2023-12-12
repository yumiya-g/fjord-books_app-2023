# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable, only: %i[create edit update]
  before_action :delete_comment, only: %i[destroy]

  def create
    comment = Comment.new(
      content: comment_params[:content],
      user_id: current_user.id,
      commentable_type: set_commentable.class.name,
      commentable_id: set_commentable[:id]
    )

    if comment.save
      redirect_to set_commentable, notice: 'コメントしました'
    else
      redirect_to set_commentable, alert: 'コメントできませんでした'
    end
  end

  def edit; end

  def update; end

  def destroy
    if delete_comment.destroy
      redirect_to request.referer, notice: 'コメントを削除しました'
    else
      redirect_to request.referer, alert: 'コメントを削除できませんでした'
    end
  end

  private

  def set_commentable
    if params[:report_id]
      Report.find(params[:report_id])
    else
      Book.find(params[:book_id])
    end
  end

  def delete_comment
    Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
