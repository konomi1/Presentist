# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '贈り物ログに関わる画面のテスト' do
  # ログイン中のuser
  let(:user) { create(:user) }
  # userのフレンド
  let!(:friend) { create(:friend, user: user) }
  # userが投稿した贈り物ログ
  let!(:present) { create(:present, user: user, friend: friend) }
  # 他のユーザー
  let!(:user2) { create(:user) }
  # 他のユーザーの贈り物ログ
  let!(:present2) { create(:present, user: user2) }
  # userが他のユーザーの贈り物ログにいいね
  let!(:favorite) { create(:favorite, user: user, present: present2) }
  # 他のユーザーが贈り物ログにコメント
  let!(:comment) { create(:comment, user: user2, present: present) }

  # userでログインする
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe '贈り物ログ一覧画面のテスト' do
    before do
      visit presents_path
    end

    context '表示内容の確認' do
      it 'URLがあっているか' do
        expect(current_path).to eq '/presents'
      end
      it '贈り物ログの贈り物シーンが表示されているか' do
        expect(page).to have_content present.scene_status_i18n
      end
      it '贈り物ログの投稿者が表示されているか' do
        expect(page).to have_content user.name
      end
      it 'userに関連した贈り物ログが表示されているか' do
        expect(page).to have_content present.item
      end
      it 'その他のuserに関連した贈り物ログが表示されているか' do
        expect(page).to have_content present2.item
      end
      it 'お気に入りlinkが表示されているか' do
        expect(page).to have_link href: favorites_path(present)
      end
      it 'コメントlinkが表示されているか' do
        expect(page).to have_link href: present_path(present, anchor: "comments-area")
      end
      it '贈り物ログ詳細へのリンクがあるか' do
        expect(page).to have_link href: present_path(present)
      end
    end
  end

  describe '贈り物詳細画面のテスト' do
    before do
      visit present_path(present)
    end

    context '表示内容の確認' do
      it 'URLがあっているか' do
        expect(current_path).to eq '/presents/' + present.id.to_s
      end
      it '贈り物ログの品名が表示されているか' do
        expect(page).to have_content present.item
      end
      it '贈り物ログの投稿者が表示されているか' do
        expect(page).to have_content user.name
      end
      it '贈り物ログの贈り物シーンが表示されているか' do
        expect(page).to have_content present.scene_status_i18n
      end
      it '贈り物ログのに関するフレンドが表示されているか' do
        expect(page).to have_content present.friend.relation_i18n
      end
      it '贈り物ログの金額が表示されているか' do
        expect(page).to have_content present.price
      end
      it '贈り物ログの一言メモが表示されているか' do
        expect(page).to have_content present.memo
      end
      it '編集ボタンが表示されているか' do
        expect(page).to have_link href: edit_present_path(present)
      end
      it '削除ボタンが表示されているか' do
        expect(page).to have_link href: present_path(present)
      end
      it 'コメントフォームが表示されているか' do
        expect(page).to have_field 'comment[comment]'
      end
      it 'コメントが表示されているか' do
        expect(page).to have_content comment.comment
      end
    end

    context '動作の確認' do
      it '編集ボタンを押すと編集ページに遷移する' do
        find('a.btn.btn-primary').click
        expect(current_path).to eq '/presents/' + present.id.to_s + '/edit'
      end
      it '削除ボタンを押すと投稿が削除される' do
        expect { find('a.btn.btn-secondary').click }.to change(Present.all, :count).by(-1)
      end
    end
  end

  describe '贈り物編集画面のテスト' do
    before do
      visit edit_present_path(present)
    end

    context '表示内容の確認' do
      it 'URLがあっているか' do
        expect(current_path).to eq '/presents/' + present.id.to_s + '/edit'
      end
      it '画像が表示されているか' do
        expect(page).to have_selector('img', id: "preview")
      end
      it '友達の名前がフォームに入っているか' do
        expect(page).to have_select('相手のお名前', selected: friend.name )
      end
      it '友達の年齢がフォームに入っているか' do
        expect(page).to have_select('相手の年齢', selected: present.age_i18n )
      end
      it '品名がフォームに入っているか' do
        expect(page).to have_field '品名', with: present.item
      end
      it '目安金額がフォームに入っているか' do
        expect(page).to have_field '目安金額', with: present.price
      end
      it 'メモがフォームに入っているか' do
        expect(page).to have_field 'メモ', with: present.memo
      end
    end

    context '動作の確認' do
      before do
        @old_age = present.age
        @old_item = present.item
        @old_price = present.price
        @old_memo = present.memo
        select '0歳', from: '相手の年齢'
        fill_in '品名', with: Faker::Lorem.characters(number: 10)
        fill_in '目安金額', with: Faker::Number.number(digits: 4)
        fill_in 'メモ', with: Faker::Lorem.characters(number: 50)
        click_button '投稿'
      end

      it '編集ボタンを押すと編集ページに遷移する' do
        expect(current_path).to eq '/presents/' + present.id.to_s
      end
      it '相手の年齢が更新される' do
        expect(present.reload.age).not_to eq @old_age
      end
      it '品名が更新される' do
        expect(present.reload.item).not_to eq @old_item
      end
      it '目安金額が更新される' do
        expect(present.reload.price).not_to eq @old_price
      end
      it 'メモが更新される' do
        expect(present.reload.memo).not_to eq @old_memo
      end
    end
  end
end
