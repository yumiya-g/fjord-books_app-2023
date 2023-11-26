# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable, only: %i[create edit update destroy]

  def create
    comment = Comment.new(
      content: comment_params[:content],
      user_id: current_user.id,
      commentable_type: @commentable.class.name,
      commentable_id: params[:report_id]
    )

    if comment.save
      redirect_to @commentable, notice: 'コメントしました'
    else
      redirect_to @commentable, alert: 'コメントできませんでした'
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def set_commentable
    @commentable = Report.find(params[:report_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
