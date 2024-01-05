# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
end

def account_name(report_owner_id)
  @account_name = User.find(report_owner_id).name.presence || User.find(report_owner_id).email
end
