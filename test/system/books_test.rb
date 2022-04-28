# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:cherry_book)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: '本'
  end

  test 'creating a Book' do
    visit books_url
    click_on '新規作成'
    fill_in 'タイトル', with: 'たのしい本'
    fill_in 'メモ', with: '面白い！'
    fill_in '著者', with: 'yamamoto'
    click_on '登録する'

    assert_text '本が作成されました。'
    assert_text 'たのしい本'
    assert_text '面白い！'
    assert_text 'yamamoto'
  end

  test 'updating a Book' do
    visit books_url
    click_on '編集'
    fill_in 'タイトル', with: 'チェリー本'
    fill_in 'メモ', with: '勉強になる！'
    fill_in '著者', with: '伊藤 淳一'
    click_on '更新する'

    assert_text '本が更新されました。'
    assert_text 'チェリー本'
    assert_text '勉強になる！'
    assert_text '伊藤 淳一'
  end

  test 'destroying a Book' do
    visit books_url
    page.accept_confirm do
      click_on '削除'
    end

    assert_text '本が削除されました。'
  end
end
