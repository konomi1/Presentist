# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Friendモデルのテスト', type: :model do
  describe 'モデルのテスト' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:friend)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    # 備考：build(:friend)はDB保存されない。オブジェクトとして扱う。
    subject { friend.valid? }

    let(:friend) { build(:friend) }
    # 有効か確認

    context 'nameカラム' do
      it '空欄は保存されない' do
        friend.name = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        friend.name = ''
        friend.valid?
        expect(friend.errors[:name]).to include("を入力してください") # blankを確認
      end
    end

    context 'kana_nameカラム(全角カタカナ以外は入力できない)' do
      it '全角カタカナは保存される' do
        friend.kana_name = "カタカナ"
        is_expected.to eq true
      end
      it '半角文字は保存されない' do
        friend.kana_name = "aaaa"
        friend.valid?
        expect(friend.errors[:kana_name]).to include("は不正な値です")
      end
      it '全角ひらがなは保存されない' do
        friend.kana_name = "ああああ"
        friend.valid?
        expect(friend.errors[:kana_name]).to include("は不正な値です")
      end
    end

    context 'memoカラム' do
      it '300文字以下である：300文字は可' do
        friend.memo = Faker::Lorem.characters(number: 300)
        is_expected.to eq true
      end
      it '300文字以下である：301文字は不可' do
        friend.memo = Faker::Lorem.characters(number: 301)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    # reflect_on_associationでアソシエーションを確認。ない場合はnilとなる。
    context 'Userモデルとの関係' do
      it '1:Nとなっている' do
        expect(Friend.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Presentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Friend.reflect_on_association(:presents).macro).to eq :has_many
      end
    end

    context 'Eventモデル(中間テーブル)との関係' do
      it '1:Nとなっている' do
        expect(Friend.reflect_on_association(:events).macro).to eq :has_many
      end
    end
  end
end
