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
    ActiveRecord::Base.transaction do
      return false unless save

      save
      save_mentions
    end
  end

  def update_with_mention(params)
    ActiveRecord::Base.transaction do
      return false unless update(params)

      update(params)
      save_mentions
    end
  end

  def save_mentions
    mentioning_mentions.destroy_all

    extracted_mentioned_reports = extract_ids(content)
    extracted_mentioned_reports.map do |mentioned_report|
      mentioning_mentions.create!(mentioned_report:)
    end
  end

  def extract_ids(report_content)
    ids = report_content.scan(%r{https?://localhost:3000/reports/(\d+)}).flatten.uniq.map(&:to_i)
    Report.where.not(id:).where(id: ids).order(id: :asc)
  end
end
