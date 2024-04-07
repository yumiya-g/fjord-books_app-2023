# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = create(:report)
    visit root_url
    fill_in 'Eメール', with: @report.user.email
    fill_in 'パスワード', with: @report.user.password
    click_button 'ログイン'
    assert_text 'ログインしました。'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'should create report' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in '内容', with: @report.content
    fill_in 'タイトル', with: @report.title
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text @report.content
    assert_text @report.title
    click_on '日報の一覧に戻る'
  end

  test 'should update Report' do
    visit report_url(@report)
    click_on 'この日報を編集', match: :first

    fill_in '内容', with: '内容を更新しました'
    fill_in 'タイトル', with: 'タイトルを更新しました'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '内容を更新しました'
    assert_text 'タイトルを更新しました'
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on 'この日報を削除', match: :first

    assert_text '日報が削除されました。'
    assert_no_text 'Aliceの日報'
    assert_no_text 'Aliceの日報の本文'
    assert_no_text @report.created_on
  end
end
