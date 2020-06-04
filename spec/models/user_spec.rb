require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザーの作成' do
    let!(:user_1) { create(:user, name: 'Bob') }
    let(:user_2) { build(:user, name: user_2_name) }
    context '名前が空文字列' do
      let(:user_2_name) { '' }
      it 'ユーザーの作成に失敗' do
        expect(user_2).not_to be_valid
      end
    end

    context '名前が他のユーザーと重複' do
      let(:user_2_name) { user_1.name }
      it 'ユーザーの作成に失敗' do
        expect(user_2).not_to be_valid
      end
    end

    context '名前が９文字以上' do
      let(:user_2_name) { 'Alexander' }
      it 'ユーザーの作成に失敗' do
        expect(user_2).not_to be_valid
      end
    end
    
    context '有効な名前' do
      let(:user_2_name) { 'Alice' }
      it 'ユーザーの作成に成功' do
        expect(user_2).to be_valid
      end
    end
  end
end