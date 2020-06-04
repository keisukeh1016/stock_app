require 'rails_helper'

RSpec.describe 'ログイン、ログアウト機能', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン機能' do
    before do
      visit login_path
    end
    context '有効なユーザー情報でログイン' do
      before do
        fill_in 'ユーザー名', with: user.name
        click_button 'ログイン'
      end
      it 'ログインに成功' do
        expect(page).to have_text 'ログインしました'
      end
    end
    context '無効なユーザー情報でログイン' do
      before do
        fill_in 'ユーザー名', with: 'Alice'
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
      fill_in 'ユーザー名', with: user.name
      click_button 'ログイン'
      click_link 'ログアウト'
    end
    it 'ログアウトに成功' do
      expect(page).to have_text 'ログアウトしました'
    end
  end
end