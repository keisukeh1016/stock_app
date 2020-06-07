require 'rails_helper'

RSpec.describe 'ユーザーの登録、削除', type: :system do
  let(:user1) { create(:user)}
  
  describe 'ユーザーの登録' do
    let(:user2) { build(:user, name: 'Alice', email: 'user2@example.com', password: 'password') }
    before do
      visit new_user_path
    end
    # context '有効な情報で新規登録' do
    #   before do
    #     fill_in 'ユーザー名', with: user2.name
    #     fill_in 'メールアドレス', with: user2.email
    #     fill_in 'パスワード', with: user2.password
    #     click_button '新規登録'
    #   end
    #   it '新規登録に成功' do
    #     expect(page).to have_text 'メールを送信しました'
    #   end
    # end
    context '無効な情報で新規登録' do
      before do
        fill_in 'ユーザー名', with: user1.name
        fill_in 'メールアドレス', with: user1.email
        fill_in 'パスワード', with: 'password' 
        click_button '新規登録'
      end
      it 'ユーザの登録に失敗' do
        expect(page).to have_text '新規登録に失敗しました'
      end
    end
  end
  
  describe 'ユーザーの削除' do
    let(:user2) { create(:user, name: 'Alice', email: 'user2@example.com') }
    before do 
      visit login_path
      fill_in 'メールアドレス', with: user2.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
    end
    context '自分のアカウントのページ' do
      before do
        visit user_path(user2)
        find_by_id("destroy_open").click 
        click_link 'アカウントを削除'
      end
      it 'ユーザーの削除に成功' do
        expect(page).to have_text 'アカウントを削除しました'
      end  
    end
    context '他人のアカウントのページ' do
      before do
        visit user_path(user1)
      end
      it 'アカウント削除ボタンが存在しない' do
        expect(page).not_to have_text 'アカウントを削除'
      end  
    end
  end
end