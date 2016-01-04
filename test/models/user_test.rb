require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(name:'Test User', email: 'TestUser@test.com',
                    password: "testpassword", password_confirmation: "testpassword")

    @empty_strings = ["   ", "\t", "\n", "\r\n"]
    @valid_email_addresses = %w[
                                abc@abc.com
                                1abc@1abc.abc
                                a-b-c@abc.com
                                a-b_c@abc.com
                                abc@a-b-c.com
                                ]
    @invalid_email_addresses = %w[
                                  ab@abc.com
                                  abc@abc,com
                                  abc@abc.1com
                                  a_b_c@a-b_c.com
                                  abc@b+c.com
                                  ]
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name can not be empty" do
    @empty_strings.each do |empty_string|
      @user.name = empty_string
      assert_not @user.valid?, "#{empty_string.inspect} should not be valid for name"
    end
  end

  test "email can not be empty" do
    @empty_strings.each do |empty_string|
      @user.email = empty_string
      assert_not @user.valid?, "#{empty_string.inspect} should not be valid for email"
    end
  end

  test "name should not be too long" do
    long_name = "a" * (User::USER_NAME_MAX_LENGTH + 1)
    @user.name = long_name
    assert_not @user.valid?
  end

  test "name should be unique" do
    dup_user = @user.dup
    dup_user.email = @valid_email_addresses.first
    @user.save
    assert_not dup_user.valid?
  end

  test "email should not be too long" do
    long_name = "a" * (User::USER_EMAIL_MAX_LENGTH + 1 - '@test.com'.length) + '@test.com'
    @user.email = long_name
    assert_not @user.valid?
  end

  test "valid email address" do
    @valid_email_addresses.each do |email|
      @user.email = email
      assert @user.valid?, "#{email.inspect} should be valid"
    end
  end

  test "invalid email addresses" do
    @invalid_email_addresses.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    @user.save
    dup_user = @user.dup

    # only email has the same value
    dup_user.name = 'dup user name'
    assert_not dup_user.valid?

    # email is not case sensitive
    dup_user.email = dup_user.email.upcase
    assert_not dup_user.valid?
  end

  test "email addresses are not case sensitive" do
    @valid_email_addresses.each do |email|
      dup_user = @user.dup

      @user.email = email
      @user.save

      upcase_email_address = email.upcase
      dup_user.email = upcase_email_address
      assert_not dup_user.valid?
    end
  end

  test "email addresses should be saved as lowcase" do
    @valid_email_addresses.each do |email|
      upcase_email = email.upcase
      @user.email = upcase_email
      @user.save
      assert email, @user.reload.email
    end
  end

  test "password length test" do
    short_passwd = "a" * (User::USER_PASSWORD_MINIMUM_LENGTH - 1)
    @user.password = short_passwd
    @user.password_confirmation = short_passwd
    assert_not @user.valid?, "password #{short_passwd.inspect} should not be valid"

    long_passwd = "a" * User::USER_PASSWORD_MINIMUM_LENGTH
    @user.password = long_passwd
    @user.password_confirmation = long_passwd
    assert @user.valid?, "password #{long_passwd.inspect} should be valid"
  end


end
