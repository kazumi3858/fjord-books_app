# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report_of_alice = reports(:report_of_alice)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報'
  end

  test 'creating a new report' do
    visit reports_url
    click_on '新規作成'
    fill_in 'タイトル', with: @report_of_alice.title
    fill_in '内容', with: @report_of_alice.content
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text '学習1日目'
    assert_text 'Linuxについて学びました。'
  end

  test 'visiting a show page' do
    visit reports_url
    click_on '詳細', match: :first
    assert_selector 'h1', text: '日報の詳細'
  end

  test 'updating a report' do
    visit reports_url
    click_on '編集'
    fill_in 'タイトル', with: '学習おやすみ'
    fill_in '内容', with: '今日はおやすみしました。'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '学習おやすみ'
    assert_text '今日はおやすみしました。'
  end

  test 'destorying a report' do
    visit reports_url
    page.accept_confirm do
      click_on '削除'
    end

    assert_text '日報が削除されました。'
  end
end
