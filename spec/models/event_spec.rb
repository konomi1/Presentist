# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Eventモデルのテスト', type: :model do
  describe 'モデルのテスト' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:event)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    # 備考：build(:event)はDB保存されない。オブジェクトとして扱う。
    let(:event) { build(:event) }
    # 有効か確認
    subject { event.valid? }

    context 'dateカラム' do
      it '空欄は保存されない' do
        event.date = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        event.date = ''
        event.valid?
        expect(event.errors[:date]).to include("を入力してください")   #blankを確認
      end
    end

    context 'ready_statusカラム' do
      it '空欄は保存されない' do
        event.ready_status = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        event.ready_status = ''
        event.valid?
        expect(event.errors[:ready_status]).to include("を入力してください")   #blankを確認
      end
    end

    context 'scene_statusカラム' do
      it '空欄は保存されない' do
        event.scene_status = ''
        is_expected.to eq false
      end
      it '空欄の場合はエラーが出る' do
        event.scene_status = ''
        event.valid?
        expect(event.errors[:scene_status]).to include("を入力してください")   #blankを確認
      end
    end
  end

  describe 'アソシエーションのテスト' do
    # reflect_on_associationでアソシエーションを確認。ない場合はnilとなる。
    context 'Userモデルとの関係' do
      it '1:Nとなっている' do
        expect(Event.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Friendモデルとの関係' do
      it '1:Nとなっている' do
        expect(Event.reflect_on_association(:friend).macro).to eq :belongs_to
      end
    end
  end

end