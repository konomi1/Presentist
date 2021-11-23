# frozen_string_literal: true

require 'rails_helper';

RSpec.describe 'Relationshipモデルのテスト', type: :model do

  describe 'モデルのテスト' do
    it "全ての項目が正しく入力されている場合は保存されるか" do
      expect(FactoryBot.build(:relationship)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    # 備考：build(:relationship)はDB保存されない。オブジェクトとして扱う。
    let(:relationship) { build(:relationship) }

    subject { relationship.valid? }

    context 'followed_idカラム' do
      it 'followed_idがない場合は保存されない' do
        relationship.followed_id = nil
        is_expected.to eq false
      end
    end

    context 'follower_idカラム' do
      it 'follower_idがない場合は保存されない' do
        relationship.follower_id = nil
        is_expected.to eq false
      end
    end
  end

  describe '一意性のテスト' do

    let(:relationship) { create(:relationship) }
    let(:user) {create(:user)}

    it 'followed_idとfollower_idが全く同じ場合は保存されない' do
      relation1 = relationship
      relation2 = FactoryBot.build(:relationship, followed_id: relation1.followed_id, follower_id: relation1.follower_id)
      expect(relation2).to be_valid
    end

    it 'followed_idとfollower_idが同じ場合は保存されない' do
      test_user = user
      relation = FactoryBot.build(:relationship, followed_id: test_user.id, follower_id: test_user.id)
      expect(relation).to be_valid
    end
  end

  describe 'アソシエーションのテスト' do
    # reflect_on_associationでアソシエーションを確認。ない場合はnilとなる。
    context 'Userモデル(followed)との関係' do
      it '1:Nとなっている' do
        expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
      end
    end

    context 'Userモデル(follower)との関係' do
      it '1:Nとなっている' do
        expect(Relationship.reflect_on_association(:follower).macro).to eq :belongs_to
      end
    end

  end

end