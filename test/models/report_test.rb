# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable?' do
    report = create(:report)
    assert report.editable?(report.user)

    other_user = create(:user)
    assert_not report.editable?(other_user)
  end

  test 'created_on' do
    report = create(:report)
    assert_equal Time.zone.now.to_date, report.created_on
  end

  test 'save_mention' do
    report1 = create(:report)
    assert_empty report1.active_mentions

    create(:report, content: 'http://localhost:3000/reports/aBＣあ漢字')
    assert_empty ReportMention.all

    report2 = create(:report, content: 'http://localhost:3000/reports/1')
    assert_not_empty report2.active_mentions
  end
end
