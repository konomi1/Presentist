# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'モデルのテスト' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'name' do
      it '空欄は保存されない' do
        user.name = ''
        is_expected.to eq false
      end
    end

    context 'introduce' do
      it '300文字以下か: 300文字は〇' do
        user.introduce = Faker::Lorem.characters(number: 300)
        is_expected.to eq true
      end
      it '300文字以下か: 301文字は×' do
        user.introduce = Faker::Lorem.characters(number: 301)
        is_expected.to eq false
      end
    end
  end
end