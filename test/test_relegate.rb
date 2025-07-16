# frozen_string_literal: true

require "test_helper"

class TestRelegate < Minitest::Test
  def setup
    User.delete_all
  end

  def test_accessor_methods
    user = User.new
    assert_equal false, user.deleted?
    assert_equal false, user.discarded?
    user.deleted_at = Time.current
    assert_equal true, user.deleted?
    assert_equal false, user.discarded?
  end

  def test_scopes
    User.create!(discarded_at: Time.current)
    assert_equal 1, User.discarded.count
    assert_equal 0, User.deleted.count
  end

  def test_state_change_methods
    user = User.create!
    assert !user.deleted?
    user.delete!
    assert user.deleted?
    user.reload
    assert user.deleted?
    user.undelete!
    assert user.undeleted?
    user.reload
    assert user.undeleted?
  end

  def test_negative_scopes
    User.create!(deleted_at: Time.current)
    assert_equal 0, User.undeleted.count
    assert_equal 1, User.undiscarded.count
  end
end
