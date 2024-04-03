# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    report = create(:report)
    assert report.editable?(report.user)

    other_user = create(:user)
    assert_not report.editable?(other_user)
  end

  test '#created_on' do
    report = create(:report)
    assert_equal Time.zone.now.to_date, report.created_on
  end

  test '#save_mention' do
    report_without_mention = create(:report)
    assert_empty report_without_mention.active_mentions

    report_with_mention = create(:report, content: 'http://localhost:3000/reports/aBＣあ漢字')
    assert_empty report_with_mention.active_mentions

    report_with_mention.update(content: 'http://localhost:3000/reports/1')
    assert_equal 1, report_with_mention.active_mentions.first.mentioned_by_id

    report_with_mention.update(content: 'http://localhost:3000/reports/hoge')
    assert_empty report_with_mention.active_mentions
  end
end
