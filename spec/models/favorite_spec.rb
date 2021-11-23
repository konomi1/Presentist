# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Favoriteモデルのテスト', type: :model do
  describe 'モデルのテスト' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:favorite)).to be_valid
    end
  end

  describe 'バリデーション(一意性)のテスト' do

    it 'user_idとpresents_idがの組み合わせが同じ場合は保存されない' do
      favorite1 = FactoryBot.create(:favorite)
      favorite2 = FactoryBot.build(:favorite, user_id: favorite1.user_id, present_id: favorite1.present_id)
      expect(favorite2.valid?).to eq false
    end

  end

  describe 'アソシエーションのテスト' do
    # reflect_on_associationでアソシエーションを確認。ない場合はnilとなる。
    context 'Userモデルとの関係' do
      it '1:Nとなっている' do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Presentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Favorite.reflect_on_association(:present).macro).to eq :belongs_to
      end
    end
  end

end