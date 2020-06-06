require 'rails_helper'

RSpec.describe '銘柄の詳細', type: :system do
  describe '銘柄の前日比の表示' do
    let(:stock) { create(:stock, dod_change: dod_change) }
    before do
      visit stock_path(stock)
    end
    context '前日比がプラスの銘柄' do
      let(:dod_change) { 1 }
      it '数字の前にプラスが表示' do
        expect(page).to have_text '+1.00%'
      end
    end

    context '前日比がマイナスの銘柄' do
      let(:dod_change) { -1 }
      it '数字の前にマイナスが表示' do
        expect(page).to have_text '-1.00%'
      end
    end
  end
end