# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = create(:book)
    @user = create(:user)
    visit root_url
    fill_in 'Eメール', with: @user.email
    fill_in 'パスワード', with: @user.password
    click_button 'ログイン'
    assert_text 'ログインしました。'
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: '本の一覧'
  end

  test 'should create book' do
    visit books_url
    click_on '本の新規作成'

    fill_in 'タイトル', with: @book.title
    fill_in 'メモ', with: @book.memo
    fill_in '著者', with: @book.author
    attach_file '画像', 'test/fixtures/files/test.png'

    click_on '登録する'
    assert_text '本が作成されました'
    assert_text @book.title
    assert_text @book.memo
    assert_text @book.author
    assert_selector "img[src='/uploads/book/picture/2/test.png']"
    click_on '本の一覧に戻る'
  end

  test 'should update Book' do
    visit book_url(@book)
    click_on 'この本を編集', match: :first

    fill_in 'メモ', with: '更新したサンプル本のタイトル'
    fill_in 'タイトル', with: '更新したサンプル本のメモ'
    fill_in '著者', with: '更新したサンプル本の著者'
    attach_file '画像', 'test/fixtures/files/test2.png'

    click_on '更新する'
    assert_text '本が更新されました。'
    assert_text '更新したサンプル本のタイトル'
    assert_text '更新したサンプル本のメモ'
    assert_text '更新したサンプル本の著者'
    assert_selector "img[src='/uploads/book/picture/1/test2.png']"
    click_on '本の一覧に戻る'
  end

  test 'should destroy Book' do
    visit book_url(@book)
    click_on 'この本を削除', match: :first

    assert_text '本が削除されました。'
  end
end
