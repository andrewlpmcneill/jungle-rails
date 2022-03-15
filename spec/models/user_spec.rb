require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    subject { User.new(name: 'test', email: 'test@test.COM', password: 'testtest', password_confirmation: 'testtest') }
    it 'successfully validates a user when password and password_confirmation are both present and match' do
      @user = User.new(name: 'test', email: 'test@test.COM', password: 'testtest', password_confirmation: 'testtest')
      expect(@user).to be_valid
    end
    it 'contains validation for matching password and password_confirmation fields' do
      @user = User.new(email: 'test@test.com', password: 'testtest', password_confirmation: 'testtest2')
      expect(@user).to_not be_valid
    end
    it 'contains validation for unique email (case insensitive)' do
      subject.save
      @user = User.new(name: 'test', email: 'test@test.COM', password: 'testtest', password_confirmation: 'testtest')
      expect(@user).to_not be_valid
    end
    it 'contains validation for email field' do
      @user = User.new(name: 'test', email: nil, password: 'testtest', password_confirmation: 'testtest')
      expect(@user).to_not be_valid
    end
    it 'contains validation for name field' do
      @user = User.new(name: nil, email: 'test@test.com', password: 'testtest', password_confirmation: 'testtest')
      expect(@user).to_not be_valid
    end
    it 'validates a password minimum length of 8 characters' do
      @user = User.new(name: 'test', email: 'test@test.COM', password: 'test', password_confirmation: 'test')
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    subject { User.new(name: 'test', email: 'test@test.COM', password: 'testtest', password_confirmation: 'testtest') }
    it 'successfully logs in when usernames and passwords match' do
      subject.save
      user = User.authenticate_with_credentials('test@test.COM', 'testtest')
      expect(user).to_not eq nil
    end
    it 'fails login when passwords do not match' do
      subject.save
      user = User.authenticate_with_credentials('test@test.COM', 'testtest2')
      expect(user).to eq nil
    end
    it 'still logs in when email has extra spaces' do
      subject.save
      user = User.authenticate_with_credentials('   test@test.COM   ', 'testtest')
      expect(user).to_not eq nil
    end
    it 'still logs in when email is not cased properly' do
      subject.save
      user = User.authenticate_with_credentials('tEsT@TESt.CoM', 'testtest')
      expect(user).to_not eq nil
    end
  end
  
end
