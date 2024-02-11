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

  def self.save_mentions(report, report_content)
    Relationship.where(mentioning_report_id: report.id).destroy_all

    mentioned_ids = extract_ids(report, report_content).compact
    mentioned_ids.map do |mentioned_id|
      relationship = Relationship.new(mentioning_report_id: report.id, mentioned_report_id: mentioned_id)
      relationship.save!
    end
  end

  def self.extract_ids(report, report_content)
    ids = report_content.scan(%r{https?://localhost:3000/reports/(\d+)}).flatten.uniq
    ids.map do |id|
      id if id != report.id.to_s && Report.find_by(id: id.to_i).present?
    end
  end
end
