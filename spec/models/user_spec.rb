require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do

    it "should have a password and password_confirmation" do
      user = User.new(
        first_name: "Rafael", last_name: "Nobrega", email: "test1@test.com", password: nil, password_confirmation: nil)
      user.save
      expect(user.errors.full_messages).to include("Password can't be blank" || "Password is too short (minimum is 3 characters)" || "Password confirmation can't be blank")                       
    end

    it "should not save without a valid first_name" do
      user = User.new(
        first_name: nil, last_name: "Nobrega", email: "test2@test.com", password: "string", password_confirmation: "string")
      user.save
      expect(user.errors.full_messages).to include("First name can't be blank")
    end
  
    it "should not save without a valid last_name" do
      user = User.new(
        first_name: "Rafael", last_name: "", email: "test3@test.com", password: "string", password_confirmation: "string")
      user.save
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end
  
    it "should not save if the passwords don't match" do
      user = User.new(
        first_name: "Rafael", last_name: "Nobrega", email: "test4@test.com", password: "string", password_confirmation: "different")
      user.save
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "should not save without a valid email" do
      user = User.new(
        first_name: "Rafael", last_name: "Nobrega", email: "test", password: "string", password_confirmation: "string")
      user.save
      expect(user.errors.full_messages).to include("Email is invalid")
    end
  
    it "should not save if the email is not unique" do
      
      user1 = User.new(
        first_name: "Rafael", last_name: "Nobrega", email: "hello@w.com", password: "string", password_confirmation: "string")
      user1.save

      user2 = User.new(
        first_name: "Rafael", last_name: "Nobrega", email: "HELLO@W.COM", password: "string", password_confirmation: "string")
      user2.save

      expect(user2.errors.full_messages).to include("Email has already been taken")
    end
  
    it "should not save if the password length is less than three characteres" do
      user = User.new(
        first_name: "Rafael", last_name: "Nobrega", email: "testpassword", password: "ab", password_confirmation: "ab")
      user.save
      expect(user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end
  end


  describe '.authenticate_with_credentials' do
    it "should return an error if credentials are not valid" do
    user = User.new(
      first_name: "Rafael", last_name: "Lacerda", email: "raf@raf.com", password: "12345", password_confirmation: "12345")
    user.save
    expect(User.authenticate_with_credentials("raf@raf.com", "12345")).to eql(user)
    # another way of checking it:
    # result = User.authenticate_with_credentials(user.email, user.password)
    # expect(result).to match(user)
    end

      
    it "should authenticate despite whitespace" do
      user = User.new(
        first_name: "Rafael", last_name: "Nobrega", email: "test@testtt.com", password: "string", password_confirmation: "string")
      user.save
      expect(User.authenticate_with_credentials("  test@testtt.com  ", "string")).to eql(user)
    end


        it "should authenticate despite wrong case" do
      user = User.new(
        first_name: "Rafael", last_name: "Nobrega", email: "rafael@r.com", password: "string", password_confirmation: "string")
      user.save
      expect(User.authenticate_with_credentials("rafael@r.COM", "string")).to eql(user)
    end


  end
end

