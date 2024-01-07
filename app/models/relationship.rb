class Relationship < ApplicationRecord
  belongs_to :mentioning_report, class_name: 'Report', foreign_key: :mentioning_report_id
  belongs_to :mentioned_report, class_name: 'Report', foreign_key: :mentioned_report_id
end
