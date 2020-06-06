require 'rails_helper'

RSpec.describe 'ポートフォリオ' do
  let(:user) { create(:user) }
  let(:stock1) { create(:stock, code: 1000) }
  let(:stock2) { create(:stock, code: 2000) }
  let(:stock3) { create(:stock, code: 3000) }
  let(:stock4) { create(:stock, code: 4000) }
  let(:stock5) { create(:stock, code: 5000) }
  let(:stock6) { create(:stock, code: 6000) }
  let!(:portfolio1) { create(:portfolio, user: user, stock: stock1) }
  let!(:portfolio2) { create(:portfolio, user: user, stock: stock2) }
  let!(:portfolio3) { create(:portfolio, user: user, stock: stock3) }
  let!(:portfolio4) { create(:portfolio, user: user, stock: stock4) }
  
  describe '追加と削除' do
    before do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
    end

    context '未登録の銘柄' do
      context 'ポートフォリオ数が４件以下の場合' do
        before do
          visit stock_path(stock5)
          click_button '追加'
        end
        it '銘柄の追加に成功' do
          expect(page).to have_text '銘柄を追加しました'
        end
      end
      context 'ポートフォリオ数が５件以上の場合' do
        let!(:portfolio5) { create(:portfolio, user: user, stock: stock5) }
        before do
          visit stock_path(stock6)
          click_button '追加'
        end
        it '銘柄の追加に失敗' do
          expect(page).to have_text '銘柄登録の上限は５件です'
        end
      end
    end

    context '登録済の銘柄' do
      before do
        visit stock_path(stock1)
        click_button '削除'
      end
      it '銘柄の削除に成功' do
        expect(page).to have_text '銘柄を削除しました'
      end
    end
  end
end