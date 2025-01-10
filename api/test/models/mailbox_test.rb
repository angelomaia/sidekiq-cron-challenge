require "test_helper"

class MailboxTest < ActiveSupport::TestCase
  setup do
    @domain = Domain.new(domain_name: "example.com", password_expiration_frequency: 30)
  end

  test "should create mailbox with valid attributes" do
    mailbox = Mailbox.new(domain: @domain, username: "user", password: "password", scheduled_password_expiration: Date.today + 30)
    assert mailbox.valid?
  end

  test "should not create mailbox without domain" do
    mailbox = Mailbox.new(username: "user", password: "password", scheduled_password_expiration: Date.today + 30)
    assert mailbox.invalid?
    assert_equal [ "Domain must exist" ], mailbox.errors.full_messages
  end

  test "should not create mailbox without username" do
    mailbox = Mailbox.new(domain: @domain, password: "password", scheduled_password_expiration: Date.today + 30)
    assert mailbox.invalid?
    assert_equal [ "Username can't be blank" ], mailbox.errors.full_messages
  end

  test "should not create mailbox without password" do
    mailbox = Mailbox.new(domain: @domain, username: "user", scheduled_password_expiration: Date.today + 30)
    assert mailbox.invalid?
    assert_equal [ "Password can't be blank", "Password is invalid" ], mailbox.errors.full_messages
  end

  test "should not create mailbox without scheduled_password_expiration" do
    mailbox = Mailbox.new(domain: @domain, username: "user", password: "password")
    assert mailbox.invalid?
    assert_equal [ "Scheduled password expiration can't be blank" ], mailbox.errors.full_messages
  end

  test "should not create mailbox with duplicate username in the same domain" do
    Mailbox.create!(domain: @domain, username: "user", password: "password", scheduled_password_expiration: Date.today + 30)
    mailbox = Mailbox.new(domain: @domain, username: "user", password: "password", scheduled_password_expiration: Date.today + 30)
    assert mailbox.invalid?
    assert_equal [ "Username has already been taken" ], mailbox.errors.full_messages
  end

  test "should allow duplicate username in different domains" do
    domain2 = Domain.new(domain_name: "example.org", password_expiration_frequency: 30)
    Mailbox.create!(domain: @domain, username: "user", password: "password", scheduled_password_expiration: Date.today + 30)
    mailbox = Mailbox.new(domain: domain2, username: "user", password: "password", scheduled_password_expiration: Date.today + 30)
    assert mailbox.valid?
  end

  test "should not create mailbox with invalid password format" do
    mailbox = Mailbox.new(domain: @domain, username: "user", password: "short", scheduled_password_expiration: Date.today + 30)
    assert mailbox.invalid?
    assert_equal [ "Password is invalid" ], mailbox.errors.full_messages
  end
end
