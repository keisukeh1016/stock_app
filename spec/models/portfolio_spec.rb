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

  describe 'ポートフォリオの登録数上限' do
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

end