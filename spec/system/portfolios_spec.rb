require 'rails_helper'

RSpec.describe 'ポートフォリオの追加、削除' do
  let(:user) { create(:user) }
  let(:stock_1) { create(:stock, code: 1000) }
  let(:stock_2) { create(:stock, code: 2000) }
  let(:stock_3) { create(:stock, code: 3000) }
  let(:stock_4) { create(:stock, code: 4000) }
  let(:stock_5) { create(:stock, code: 5000) }
  let(:stock_6) { create(:stock, code: 6000) }
  before do
    create(:portfolio, user: user, stock: stock_1)
    create(:portfolio, user: user, stock: stock_2)
    create(:portfolio, user: user, stock: stock_3)
    create(:portfolio, user: user, stock: stock_4)
  end

  context 'ログインしていない場合' do
    before do
      visit stock_path(stock_1)
    end
    it 'ポートフォリオボタンが表示されない' do      
      expect(page).not_to have_css 'input[type="submit"]'
    end
  end

  context 'ログインしている場合' do
    before do
      visit login_path
      fill_in 'ユーザー名', with: user.name
      click_button 'ログイン'
    end

    context '未登録の銘柄' do
      context 'ポートフォリオ数が４件以下の場合' do
        before do
          visit stock_path(stock_5)
          click_button '追加'
        end
        it 'ポートフォリオが追加できる' do
          expect(page).to have_text '銘柄を追加しました'
        end
      end
      context 'ポートフォリオ数が５件以上の場合' do
        before do
          create(:portfolio, user: user, stock: stock_5)
          visit stock_path(stock_6)
          click_button '追加'
        end
        it 'ポートフォリをの追加に失敗' do
          expect(page).to have_text '銘柄登録の上限は５件です'
        end
      end
    end

    context '登録済の銘柄' do
      before do
        visit stock_path(stock_1)
        click_button '削除'
      end
      it 'ポートフォリオが削除できる' do
        expect(page).to have_text '銘柄を削除しました'
      end
    end
  end
end