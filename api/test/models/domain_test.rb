require "test_helper"

class DomainTest < ActiveSupport::TestCase
  test "should create domain with valid attributes" do
    domain = Domain.new(domain_name: "example.com", password_expiration_frequency: 30)
    assert domain.valid?
  end

  test "should not create domain without domain_name" do
    domain = Domain.new(password_expiration_frequency: 30)
    assert_not domain.valid?
    assert_includes domain.errors.full_messages, "Domain name can't be blank"
  end

  test "should not create domain with duplicate domain_name" do
    Domain.create(domain_name: "example.com", password_expiration_frequency: 30)
    domain = Domain.new(domain_name: "example.com", password_expiration_frequency: 60)
    assert_not domain.valid?
    assert_includes domain.errors.full_messages, "Domain name has already been taken"
  end

  test "should not create domain with non-positive password_expiration_frequency" do
    domain = Domain.new(domain_name: "example.com", password_expiration_frequency: -10)
    assert_not domain.valid?
    assert_includes domain.errors.full_messages, "Password expiration frequency must be greater than 0"
  end
end
