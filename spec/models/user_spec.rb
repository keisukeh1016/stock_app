require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザーの作成' do
    let!(:user1) { create(:user) }
    let(:user2) { build(:user, name: user2_name, email: user2_email, password: user2_password) }

    describe 'ユーザー名' do
      let(:user2_email) { 'user2@example.com' }
      let(:user2_password) { 'password' }
      context '名前が空文字列' do
        let(:user2_name) { '' }
        it 'ユーザーの作成に失敗' do
          expect(user2).not_to be_valid
        end
      end
      context '名前が他のユーザーと重複' do
        let(:user2_name) { user1.name }
        it 'ユーザーの作成に失敗' do
          expect(user2).not_to be_valid
        end
      end
      context '名前が９文字以上' do
        let(:user2_name) { 'Alexander' }
        it 'ユーザーの作成に失敗' do
          expect(user2).not_to be_valid
        end
      end
      context '名前が８文字以下' do
        let(:user2_name) { 'Alice' }
        it 'ユーザーの作成に成功' do
          expect(user2).to be_valid
        end
      end
    end

    describe 'メールアドレス' do
      let(:user2_name) { 'Alice' }
      let(:user2_password) { 'password' }
      context 'メールアドレスが空文字列' do
        let(:user2_email) { '' }
        it 'ユーザーの登録に失敗' do
          expect(user2).not_to be_valid
        end
      end
      context 'メールアドレスが他のユーザーの重複' do
        let(:user2_email) { user1.email }
        it 'ユーザーの登録に失敗' do
          expect(user2).not_to be_valid
        end
      end
    end

    describe 'パスワード' do
      let(:user2_name) { 'Alice' }
      let(:user2_email) { 'user2@example.com' }
      context 'パスワードが空文字列' do
        let(:user2_password) { '' }
        it 'ユーザーの登録に失敗' do
          expect(user2).not_to be_valid
        end
      end
      context 'パスワードが５文字以下' do
        let(:user2_password) { 'pass' }
        it 'ユーザーの登録に失敗' do
          expect(user2).not_to be_valid
        end
      end
      context 'パスワードが６文字以下' do
        let(:user2_password) { 'password' }
        it 'ユーザーの登録に成功' do
          expect(user2).to be_valid
        end
      end
    end

  end
end