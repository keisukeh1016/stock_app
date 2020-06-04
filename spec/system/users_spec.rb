require 'rails_helper'

RSpec.describe 'ユーザーの登録、削除', type: :system do
  let(:user_1) { create(:user, name: 'Bob') }
  let(:user_2) { create(:user, name: 'Alice') }

  describe 'ユーザーの登録' do
    before do
      visit new_user_path
    end
    context '存在しないユーザー名で新規登録' do
      before do
        fill_in 'ユーザー名', with: 'Dave'
        click_button '新規登録'
      end
      it 'ユーザの登録に成功' do
        expect(page).to have_text '新規登録しました'
      end
    end
    context '既に存在するユーザー名で新規登録' do
      before do
        fill_in 'ユーザー名', with: user_1.name
        click_button '新規登録'
      end
      it 'ユーザの登録に失敗' do
        expect(page).to have_text '新規登録に失敗しました'
      end
    end
  end
  
  describe 'ユーザーの削除' do
    before do 
      visit login_path
      fill_in 'ユーザー名', with: user_1.name
      click_button 'ログイン'
    end
    context '自分のアカウントのページ' do
      before do
        visit user_path(user_1)
        click_link 'アカウントを削除'
      end
      it 'ユーザーの削除に成功' do
        expect(page).to have_text 'アカウントを削除しました'
      end  
    end
    context '他人のアカウントのページ' do
      before do
        visit user_path(user_2)
      end
      it 'アカウント削除ボタンが存在しない' do
        expect(page).not_to have_text 'アカウントを削除'
      end  
    end
  end
end