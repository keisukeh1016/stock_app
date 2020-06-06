require 'rails_helper'

RSpec.describe 'セッション', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン機能' do
    before do
      visit login_path
      fill_in 'メールアドレス', with: user.email
    end
    context '有効なパスワードでログイン' do
      before do
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
      end
      it 'ログインに成功' do
        expect(page).to have_text 'ログインしました'
      end
    end
    context '無効なパスワードでログイン' do
      before do
        fill_in 'パスワード', with: 'pass'
        click_button 'ログイン'
      end
      it 'ログインに失敗' do
        expect(page).to have_text 'ログインに失敗しました'
      end
    end
  end

  describe 'ログアウト機能' do
    before do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      click_link 'ログアウト'
    end
    it 'ログアウトに成功' do
      expect(page).to have_text 'ログアウトしました'
    end
  end
end