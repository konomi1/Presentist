# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'モデルのテスト' do
    it "全ての項目が正しく入力されている場合は保存されるか" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    # 備考：build(:user)はDB保存されない。オブジェクトとして扱う。
    subject { user.valid? }

    let(:user) { build(:user) }
    # 備考：一意性確認のためDBに保存しておく。
    let!(:user_2) { create(:user) }
    # is_expectedとセットで使う。

    context 'nameカラム' do
      it '空欄は保存されない' do
        user.name = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        user.name = ''
        user.valid?
        expect(user.errors[:name]).to include("を入力してください") # blankを確認
      end
      it '20文字以下である：20文字は可︎' do
        user.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下である：21文字は不可' do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'emailカラム' do
      it '空欄は保存されない' do
        user.email = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        user.email = ''
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end
      it '重複するemailは保存されない' do
        user.email = user_2.email
        is_expected.to eq false
      end
      it '重複するemailの場合はエラーが出る' do
        user.email = user_2.email
        user.valid?
        expect(user.errors[:email]).to include("はすでに存在します") # tokenを確認
      end
    end

    context 'birthdayカラム' do
      it '空欄は保存されない' do
        user.birthday = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        user.birthday = ''
        user.valid?
        expect(user.errors[:birthday]).to include("を入力してください")
      end
    end

    context 'genderカラム' do
      it '空欄は保存されない' do
        user.gender = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        user.gender = ''
        user.valid?
        expect(user.errors[:gender]).to include("を入力してください")
      end
    end

    context 'introduceカラム' do
      it '300文字以下である: 300文字は可' do
        user.introduce = Faker::Lorem.characters(number: 300)
        is_expected.to eq true
      end
      it '300文字以下である: 301文字は不可' do
        user.introduce = Faker::Lorem.characters(number: 301)
        is_expected.to eq false
      end
    end

    # device機能だが、一応テスト実施。
    context 'passwordカラム' do
      it '空欄は保存されない' do
        user.password = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        user.password = ''
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end
      it '6文字以上である：5文字は不可' do
        user.password = Faker::Lorem.characters(number: 5)
        is_expected.to eq false
      end
      it '6文字以上でない場合はエラーが出る' do
        user.password = Faker::Lorem.characters(number: 5)
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end
    end
  end

  describe 'アソシエーションのテスト' do
    # reflect_on_associationでアソシエーションを確認。ない場合はnilとなる。
    context 'Presentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:presents).macro).to eq :has_many
      end
    end

    context 'Friendモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:friends).macro).to eq :has_many
      end
    end

    context 'Eventモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:events).macro).to eq :has_many
      end
    end

    context 'commentsモデル(中間テーブル)との関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'Favoriteモデル(中間テーブル)との関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'Relationshipモデル(active_relationships)との関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:active_relationships).macro).to eq :has_many
      end
    end

    context 'Relationshipモデル(passive_relationships)との関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:passive_relationships).macro).to eq :has_many
      end
    end
  end
end
