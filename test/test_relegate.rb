# frozen_string_literal: true

require "test_helper"

class TestRelegate < Minitest::Test
  def setup
    User.delete_all
  end

  def test_accessor_methods
    user = User.new
    assert_equal false, user.archived?
    assert_equal false, user.discarded?
    user.archived_at = Time.current
    assert_equal true, user.archived?
    assert_equal false, user.discarded?
  end

  def test_scopes
    User.create!(discarded_at: Time.current)
    assert_equal 1, User.discarded.count
    assert_equal 0, User.archived.count
  end

  def test_state_change_methods
    user = User.create!
    assert !user.archived?
    user.archive!
    assert user.archived?
    user.reload
    assert user.archived?
    user.unarchive!
    assert user.unarchived?
    user.reload
    assert user.unarchived?
  end

  def test_negative_scopes
    User.create!(archived_at: Time.current)
    assert_equal 0, User.unarchived.count
    assert_equal 1, User.undiscarded.count
  end
end
