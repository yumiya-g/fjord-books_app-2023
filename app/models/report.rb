# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :mentioning_mentions,
           class_name: 'Relationship',
           foreign_key: :mentioning_report_id,
           dependent: :destroy,
           inverse_of: :mentioning_report

  has_many :mentioning_reports,
           through: :mentioning_mentions,
           source: :mentioned_report

  has_many :mentioned_mentions,
           class_name: 'Relationship',
           foreign_key: :mentioned_report_id,
           dependent: :destroy,
           inverse_of: :mentioned_report

  has_many :mentioned_reports,
           through: :mentioned_mentions,
           source: :mentioning_report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def save_with_mention
    return false unless save

    ActiveRecord::Base.transaction do
      save!
      save_mentions
    end
  end

  def update_with_mention(params)
    return false unless update(params)

    ActiveRecord::Base.transaction do
      update!(params)
      save_mentions
    end
  end

  def save_mentions
    Relationship.where(mentioning_report_id: id).destroy_all

    mentioned_reports = extract_ids(content)
    mentioned_reports.map do |mentioned_report|
      relationship = Relationship.new(mentioning_report_id: id, mentioned_report_id: mentioned_report.id)
      relationship.save!
    end
  end

  def extract_ids(report_content)
    ids = report_content.scan(%r{https?://localhost:3000/reports/(\d+)}).flatten.uniq.map(&:to_i)
    Report.where.not(id:).where(id: ids).order(id: :asc)
  end
end
