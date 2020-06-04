require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  let(:user) { create(:user) }
  let(:stock_1) { create(:stock, code: 1000) }
  let(:stock_2) { create(:stock, code: 2000) }
  let(:stock_3) { create(:stock, code: 3000) }
  let(:stock_4) { create(:stock, code: 4000) }
  let(:stock_5) { create(:stock, code: 5000) }
  let(:stock_6) { create(:stock, code: 6000) }
  let!(:portfolio_1) { create(:portfolio, user: user, stock: stock_1) }
  let!(:portfolio_2) { create(:portfolio, user: user, stock: stock_2) }
  let!(:portfolio_3) { create(:portfolio, user: user, stock: stock_3) }
  let!(:portfolio_4) { create(:portfolio, user: user, stock: stock_4) }

  context '一人のユーザーが同じ銘柄を登録する' do
    let(:portfolio_5) { build(:portfolio, user: user, stock: stock_1) }
    it '登録に失敗' do
      expect(portfolio_5).not_to be_valid
    end
  end

  describe 'ポートフォリオの登録数上限' do
    context '登録済み銘柄が４件以下のとき' do
      let(:portfolio_5) { build(:portfolio, user: user, stock: stock_5) }
      it '登録に成功' do
        expect(portfolio_5).to be_valid
      end
    end
    context '登録済み銘柄が５件以上のとき' do
      let!(:portfolio_5) { create(:portfolio, user: user, stock: stock_5) }
      let(:portfolio_6) { build(:portfolio, user: user, stock: stock_6) }
      it '登録に失敗' do
        expect(portfolio_6).not_to be_valid
      end
    end
  end

end