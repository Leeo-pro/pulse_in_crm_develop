# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let :user do
    FactoryBot.build :user
  end

  describe 'バリデーションについて' do
    subject do
      user
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#email' do
      context '存在しない場合' do
        before :each do
          subject.email = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Eメールを入力してください')
        end
      end

      context 'uniqueでない場合' do
        before :each do
          user = create(:user)
          subject.email = user.email
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Eメールはすでに存在します')
        end
      end

      %i[
        email0.com
        あああ.com
        今井.com
        @@.com
      ].each do |email|
        context '不正なemailの場合' do
          before :each do
            subject.email = email
          end

          it 'バリデーションに落ちること' do
            expect(subject).to be_invalid
          end

          it 'バリデーションのエラーが正しいこと' do
            subject.valid?
            expect(subject.errors.full_messages).to include('Eメールは不正な値です')
          end
        end
      end
    end

    describe '#name' do
      context '存在しない場合' do
        before :each do
          subject.name = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Nameを入力してください')
        end
      end

      context '文字数が1文字の場合' do
        before :each do
          subject.name = 'a' * 1
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '文字数が10文字の場合' do
        before :each do
          subject.name = 'a' * 10
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '文字数が11文字の場合' do
        before :each do
          subject.name = 'a' * 11
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Nameは10文字以内で入力してください')
        end
      end
    end

    describe '#gender' do
      context '存在しない場合' do
        before :each do
          subject.gender = nil
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end
    end

    describe '#age' do
      context '存在しない場合' do
        before :each do
          subject.age = nil
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context 'ageが9の時' do
        before :each do
          subject.age = 9
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Ageは10以上の値にしてください')
        end
      end

      context 'ageが10の時' do
        before :each do
          subject.age = 10
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end
    end

    describe '#password' do
      context '存在しない場合' do
        before :each do
          subject.password = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('パスワードを入力してください')
        end
      end

      context '11文字の場合' do
        before :each do
          subject.password = 'AAAAaaaa111'
          subject.password_confirmation = 'AAAAaaaa111'
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('パスワードは12文字以上で入力してください')
        end
      end

      context '12字の場合' do
        before :each do
          subject.password = 'AAAAaaaa1111'
          subject.password_confirmation = 'AAAAaaaa1111'
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '大文字がない場合' do
        before :each do
          subject.password = 'aaaaaa111111'
          subject.password_confirmation = 'aaaaaa111111'
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('パスワードパスワードは半角12文字以上で英大文字・小文字・数字それぞれ１文字以上含む必要があります')
        end
      end

      context '小文字がない場合' do
        before :each do
          subject.password = 'AAAAAA111111'
          subject.password_confirmation = 'AAAAAA111111'
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('パスワードパスワードは半角12文字以上で英大文字・小文字・数字それぞれ１文字以上含む必要があります')
        end
      end

      context '数字がない場合' do
        before :each do
          subject.password = 'AAAAAAaaaaaa'
          subject.password_confirmation = 'AAAAAAaaaaaa'
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('パスワードパスワードは半角12文字以上で英大文字・小文字・数字それぞれ１文字以上含む必要があります')
        end
      end
    end
  end
end
