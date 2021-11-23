# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ログイン前のテスト' do

  describe 'トップ画面のテスト' do

    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'root_pathのURLが/である' do
        expect(current_path).to eq '/'
      end
      it 'Aboutリンクが表示されているか' do
        expect(page).to have_link "About", href: about_path
      end
      it 'Log inリンクが表示されているか' do
        expect(page).to have_link "Log in", href: new_user_session_path
      end
      it 'Sign Upリンクが表示されているか' do
        expect(page).to have_link "Sign up", href: new_user_registration_path
      end
      it 'Rankingリンクが表示されているか' do
        expect(page).to have_link "Ranking", href: ranking_path
      end
    end
  end


  describe 'アバウト画面のテスト' do

    before do
      visit about_path
    end

    context '表示内容の確認' do
      it 'URLが正しいか' do
        expect(current_path).to eq '/about'
      end
      it 'Topリンクが表示されているか' do
        expect(page).to have_link "Top", href: root_path
      end
      it 'Log inリンクが表示されているか' do
        expect(page).to have_link "Log in", href: new_user_session_path
      end
      it 'Sign Upリンクが表示されているか' do
        expect(page).to have_link "Sign up", href: new_user_registration_path
      end
      it 'Rankingリンクが表示されているか' do
        expect(page).to have_link "Ranking", href: ranking_path
      end
    end
  end

  describe '新規登録画面のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it 'ニックネームのフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'メールアドレスのフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it '生年月日のフォームが表示される' do
        expect(page).to have_field 'user[birthday]'
      end
      it '性別のフォームが表示される' do
        expect(page).to have_field 'user[gender]'
      end
      it 'パスワードのフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'パスワード確認フォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end

    context '新規登録できるか' do
      #formに値を入れる
      before do
        fill_in 'user[name]', with: Gimei.name.kanji
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[birthday]', with: Faker::Date.birthday(min_age: 18, max_age: 80)
        choose 'user_gender_female'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '新規登録できる' do
        # 会員が一人増えることで確認。
        expect { click_button '新規登録' }.to change(User.all, :count).by(1)
      end
      it '新規登録ボタンをクリックするとランキング画面に遷移する' do
        click_button '新規登録'
        expect(current_path).to eq '/ranking'
      end
      # 新規登録失敗はmodel/user_spec.rbで確認できる。
    end
  end


  describe 'ログイン画面のテスト' do
    # 登録済み会員
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it 'メールアドレスのフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'パスワードのフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
    end

    context 'ログインできるか' do
      #formに値を入れる
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end

      it 'ログイン後はランキング画面に遷移する' do
        expect(current_path).to eq '/ranking'
      end
    end
  end


  describe 'ランキング画面のテスト' do

    before do
      visit ranking_path
    end

    context '表示内容の確認' do
      it 'URLが正しいか' do
        expect(current_path).to eq '/ranking'
      end
      it 'カレンダーは非表示か' do
        expect(page).not_to have_selector('h1', text: "Schedule")
      end
      it '贈り物ログランキングが３件表示されるか' do
        # expect(page).not_to have_selector
      end
      it '新規登録へのリンクが表示されているか' do
        expect(page).to have_link "こちら", href: new_user_registration_path
      end
    end

    context 'サイドバーの確認' do
      it 'Topリンクが表示されているか' do
        expect(page).to have_link "Top", href: root_path
      end
      it 'Log inリンクが表示されているか' do
        expect(page).to have_link "Log in", href: new_user_session_path
      end
      it 'Sign Upリンクが表示されているか' do
        expect(page).to have_link "Sign Up", href: new_user_registration_path
      end
      it 'Rankingリンクが表示されているか' do
        expect(page).to have_link "Ranking", href: ranking_path
      end
    end
  end

end