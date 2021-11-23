# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do
  describe 'モデルのテスト' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:comment)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    # 備考：build(:comment)はDB保存されない。オブジェクトとして扱う。
    let(:comment) { build(:comment) }
    # 有効か確認
    subject { comment.valid? }

    context 'commentカラム' do
      it '空欄は保存されない' do
        comment.comment = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        comment.comment = ''
        comment.valid?
        expect(comment.errors[:comment]).to include("を入力してください")   #blankを確認
      end
      it '300文字以下である：300文字は可' do
        comment.comment = Faker::Lorem.characters(number: 300)
        is_expected.to eq true
      end
      it '300文字以下である：301文字は不可' do
        comment.comment = Faker::Lorem.characters(number: 301)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    # reflect_on_associationでアソシエーションを確認。ない場合はnilとなる。
    context 'Userモデルとの関係' do
      it '1:Nとなっている' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Presentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Comment.reflect_on_association(:present).macro).to eq :belongs_to
      end
    end
  end

end