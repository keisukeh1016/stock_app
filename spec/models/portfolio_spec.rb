require 'rails_helper'

RSpec.describe Portfolio, type: :model do
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

  context '一人のユーザーが同じ銘柄を登録する' do
    let(:portfolio5) { build(:portfolio, user: user, stock: stock1) }
    it '登録に失敗' do
      expect(portfolio5).not_to be_valid
    end
  end

  describe '登録数上限' do
    context '登録済み銘柄が４件以下のとき' do
      let(:portfolio5) { build(:portfolio, user: user, stock: stock5) }
      it '登録に成功' do
        expect(portfolio5).to be_valid
      end
    end
    context '登録済み銘柄が５件以上のとき' do
      let!(:portfolio5) { create(:portfolio, user: user, stock: stock5) }
      let(:portfolio6) { build(:portfolio, user: user, stock: stock6) }
      it '登録に失敗' do
        expect(portfolio6).not_to be_valid
      end
    end
  end

  describe '保有数の値' do
    context '保有数が負の整数のとき' do
      let(:portfolio5) { build(:portfolio, user: user, stock: stock5, holding: -1) }
      it '登録に失敗' do
        expect(portfolio5).not_to be_valid
      end
    end

    context '保有数が小数のとき' do
      let(:portfolio5) { build(:portfolio, user: user, stock: stock5, holding: 1.5) }
      it '登録に失敗' do
        expect(portfolio5).not_to be_valid
      end
    end

    context '保有数が正の整数のとき' do
      let(:portfolio5) { build(:portfolio, user: user, stock: stock5, holding: 1) }
      it '登録に成功' do
        expect(portfolio5).to be_valid
      end
    end
  end

  describe '現金の増減' do
    let!(:before_cash) { user.wallet.cash }

    context '銘柄を購入した場合' do
      let!(:portfolio5) { create(:portfolio, user: user, stock: stock5, holding: 1) }
      let!(:after_cash) { before_cash - (portfolio5.stock.today_price * portfolio5.holding) }
      it '現金が減少' do
        expect(user.wallet.cash).to eq(after_cash)
      end
    end

    context '保有数を変更した場合' do
      let!(:before_holding) { portfolio4.holding }
      before do
        portfolio4.update(holding: 3)
      end
      let!(:after_cash) { before_cash - ( portfolio4.stock.today_price * (portfolio4.holding - before_holding) ) }

      it '現金が変化' do
        expect(user.wallet.cash).to eq(after_cash)
      end
    end
  
    context '銘柄を売却した場合' do
      let!(:after_cash) { before_cash + (portfolio4.stock.today_price * portfolio4.holding) }
      before do
        portfolio4.destroy
      end
      it '現金が増加' do
        expect(user.wallet.cash).to eq(after_cash)
      end
    end
  end

end