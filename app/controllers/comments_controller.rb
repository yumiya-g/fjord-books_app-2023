# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: %i[edit update destroy]

  def create
    comment = Comment.new(
      content: comment_params[:content],
      user_id: current_user.id,
      commentable_type: @commentable.class.name,
      commentable_id: @commentable[:id]
    )

    if comment.save
      redirect_to @commentable, notice: 'コメントしました'
    else
      redirect_to @commentable, alert: 'コメントできませんでした'
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @commentable, notice: 'コメントを更新しました'
    else
      render :edit, status: :unprocessable_entity, alert: 'コメントが不正です'
    end
  end

  def destroy
    if @comment.destroy
      flash[:notice] = 'コメントを削除しました'
    else
      flash[:alert] = 'コメントを削除できませんでした'
    end
    redirect_to request.referer
  end

  private

  def set_commentable
    @commentable = if params[:report_id]
                     Report.find(params[:report_id])
                   elsif params[:book_id]
                     Book.find(params[:book_id])
                   end
  end

  def set_comment
    @comment = Comment.find(params[:id])
    @commentable = Comment.find(params[:id]).commentable
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
