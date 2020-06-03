require 'rails_helper'

RSpec.describe '銘柄', type: :system do
  before do
    
  end

  describe '銘柄一覧ページ' do
    it '銘柄一覧が表示される' do
      visit '/stocks'
    end
  end

  describe '銘柄詳細ページ' do

  end
end