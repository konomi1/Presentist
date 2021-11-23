# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '会員に関わる画面のテスト' do
  # ログイン中のuser
  let(:user) { create(:user) }
  # userが投稿した贈り物ログ
  let!(:present) { create(:present, user: user) }
  # 他のユーザー
  let!(:user2) { create(:user) }
  # 他のユーザーの贈り物ログ
  let!(:present2) { create(:present, user: user2) }
  # userが他のユーザーの贈り物ログにいいね
  let!(:favorite) { create(:favorite, user: user, present: present2)}

  # userでログインする
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe '会員詳細画面のテスト' do

    before do
      visit user_path(user)
    end

    context '表示内容の確認' do
      it 'URLがあっているか' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
      it '会員編集ボタンが表示されているか' do
        expect(page).to have_link "編集", href: edit_user_path(user)
      end
      it 'follower一覧ボタンが表示されているか' do
        expect(page).to have_link user.followers.count, href: follow_user_path(user, anchor: "tab1")
      end
      it 'following一覧ボタンが表示されているか' do
        expect(page).to have_link user.followings.count, href: follow_user_path(user, anchor: "tab2")
      end
      it 'お気に入り一覧ボタンが表示されているか' do
        expect(page).to have_link user.favorites.count, href: favorites_user_path(user)
      end
      it 'userの名前が表示されているか' do
        expect(page).to have_content user.name
      end
      it 'userの自己紹介が表示されているか' do
        expect(page).to have_content user.introduce
      end
      it 'userに関連した贈り物ログが表示されているか' do
        expect(page).to have_content present.item
      end
      it 'userに関連した贈り物ログのお返しステータスボタンが表示されているか' do
        expect(page).to have_link present.return_status_i18n, href: switch_return_status_present_path(present.id)
      end
    end

    context 'ステータスボタンの変更' do
      it 'お返しボタンをクリックすると表示が変わるか' do
      click_link "お返し準備中", match: :first
      expect(page).to have_link "お返し済", href: switch_return_status_present_path(present.id)
      end
      it 'お返し済ボタンをクリックすると表示が変わるか' do
      click_link "お返し準備中", match: :first
      click_link "お返し済", match: :first
      expect(page).to have_link "お返し準備中", href: switch_return_status_present_path(present.id)
      end
    end

  end

  describe '会員編集画面のテスト' do

    before do
      visit edit_user_path(user)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it 'ニックネームのフォームが表示される' do
        expect(page).to have_field 'ニックネーム', with: user.name
      end
      it '画像投稿のフォームが表示される' do
        expect(page).to have_field 'user[image]'
      end
      it '自己紹介のフォームが表示される' do
        expect(page).to have_field '自己紹介', with: user.introduce
      end
      it '更新ボタンが表示される' do
        expect(page).to have_button '更新'
      end
    end

    context '編集のテスト' do
      before do
        @old_name = user.name
        @old_introduce = user.introduce
        fill_in 'ニックネーム', with: Gimei.name.kanji
        fill_in '自己紹介', with: Faker::Lorem.characters(number: 50)
        click_button '更新'
      end

      it 'ニックネームが更新される' do
        expect(user.reload.name).not_to eq @old_name
      end
      it '自己紹介が更新される' do
        expect(user.reload.introduce).not_to eq @old_introduce
      end
      it '更新すると会員詳細画面に遷移する' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end

  describe 'いいね一覧画面のテスト' do

    before do
      visit favorites_user_path(user)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/favorites'
      end
      it '会員がいいねした贈り物ログが表示される' do
        expect(page).to have_content present2.item
      end
    end
  end

end