# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Presentモデルのテスト', type: :model do
  describe 'モデルのテスト' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:present)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    # 備考：build(:present)はDB保存されない。オブジェクトとして扱う。
    subject { present.valid? }

    let(:present) { build(:present) }
    # 有効か確認

    context 'ageカラム' do
      it '空欄は保存されない' do
        present.age = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        present.age = ''
        present.valid?
        expect(present.errors[:age]).to include("を入力してください") # blankを確認
      end
    end

    context 'itemカラム' do
      it '空欄は保存されない' do
        present.item = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        present.item = ''
        present.valid?
        expect(present.errors[:item]).to include("を入力してください") # blankを確認
      end
    end

    context 'priceカラム(半角数字以外は入力できない)' do
      it '半角数値は保存される' do
        present.price = "1111"
        is_expected.to eq true
      end
      it '半角英字は保存されない' do
        present.price = "aaaa"
        present.valid?
        expect(present.errors[:price]).to include("は数値で入力してください")
      end
      it '全角文字は保存されない' do
        present.price = "あああ"
        present.valid?
        expect(present.errors[:price]).to include("は数値で入力してください")
      end
    end

    context 'memoカラム' do
      it '300文字以下である：300文字は可' do
        present.memo = Faker::Lorem.characters(number: 300)
        is_expected.to eq true
      end
      it '300文字以下である：301文字は不可' do
        present.memo = Faker::Lorem.characters(number: 301)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    # reflect_on_associationでアソシエーションを確認。ない場合はnilとなる。
    context 'Userモデルとの関係' do
      it '1:Nとなっている' do
        expect(Present.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Friendモデルとの関係' do
      it '1:Nとなっている' do
        expect(Present.reflect_on_association(:friend).macro).to eq :belongs_to
      end
    end

    context 'Favoriteモデル(中間テーブル)との関係' do
      it '1:Nとなっている' do
        expect(Present.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'Commentモデル(中間テーブル)との関係' do
      it '1:Nとなっている' do
        expect(Present.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
  end
end
