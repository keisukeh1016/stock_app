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
  let!(:before_cash) { user.wallet.cash }

  describe 'ログイン状態' do
    before do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
    end

    describe '銘柄の追加' do
      context '正常な銘柄の登録' do
        let(:after_cash) { before_cash - (stock5.today_price * 2) }
        before do
          visit stock_path(stock5)
          find('.holding_field').fill_in with: '2'
          click_button '購入'
        end
        it '購入に成功' do
          expect(page).to have_text "銘柄を購入しました"
        end
        it '現金が減少' do
          expect( find('.user_cash') ).to have_text( after_cash.to_i.to_s ) 
        end
      end

      context '負の整数を入力' do
        before do
          visit stock_path(stock5)
          find('.holding_field').fill_in with: '-1'
          click_button '購入'
        end
        it '購入に失敗' do
          expect(page).to have_text "正の整数を入力してください"
        end
        it '現金に変化なし' do
          expect( find('.user_cash') ).to have_text( before_cash.to_i.to_s ) 
        end
      end

      context '６件目の銘柄登録' do
        before do
          visit stock_path(stock5)
          find('.holding_field').fill_in with: '1'
          click_button '購入'
          visit stock_path(stock6)
          find('.holding_field').fill_in with: '1'
          click_button '購入'
        end
        it '購入に失敗' do
          expect(page).to have_text "銘柄登録の上限は５件です"
        end
        it '現金が減少' do
          expect( find('.user_cash') ).to have_text( ( before_cash - (stock5.today_price * 1) ).to_i.to_s ) 
        end
      end

      context '現金が不足している' do
        before do
          visit stock_path(stock5)
          find('.holding_field').fill_in with: '10'
          click_button '購入'
        end
        it '購入に失敗' do
          expect(page).to have_text "現金が不足しています"
        end
        it '現金に変化なし' do
          expect( find('.user_cash') ).to have_text( before_cash.to_i.to_s ) 
        end
      end
    end

    describe '保有数の更新' do
      context '銘柄詳細ページで更新' do
        before do
          visit stock_path(stock1)
          find('.holding_field').fill_in with: '2'
          click_button '更新'
        end
        it '購入に成功' do
          expect(page).to have_text "売買が完了しました"
        end
        it '現金が減少' do
          expect( find('.user_cash') ).to have_text( ( before_cash - (stock1.today_price * 1) ).to_i.to_s ) 
        end
      end

      context 'マイページで更新' do
        before do
          visit user_path(user)
          find('tr:nth-child(2) .open_button').click
          find('.holding_field').fill_in with: '2'
          click_button '更新'
        end
        it '購入に成功' do
          expect(page).to have_text "売買が完了しました"
        end
        it '現金が減少' do
          expect( find('.user_cash') ).to have_text( ( before_cash - (stock1.today_price * 1) ).to_i.to_s ) 
        end
      end
    end

    describe '銘柄の削除' do
      context '銘柄詳細ページで削除' do
        before do
          visit stock_path(stock1)
          click_button '全売却'
        end
        it '削除に成功' do
          expect(page).to have_text "銘柄を売却しました"
        end
        it '現金が増加' do
          expect( find('.user_cash') ).to have_text( ( before_cash + (stock1.today_price * 1) ).to_i.to_s ) 
        end
      end

      context 'マイページで削除' do
        before do
          visit user_path(user)
          find('tr:nth-child(2) .open_button').click
          click_button '全売却'
        end
        it '削除に成功' do
          expect(page).to have_text "銘柄を売却しました"
        end
        it '現金が増加' do
          expect( find('.user_cash') ).to have_text( ( before_cash + (stock1.today_price * 1) ).to_i.to_s ) 
        end
      end
    end
  end
end