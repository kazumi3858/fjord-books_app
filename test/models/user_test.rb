# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    carol = users(:carol)
    assert_equal 'carol@example.com', carol.name_or_email

    carol.name = 'Carol'
    assert_equal 'Carol', carol.name_or_email
  end

  test '#follow' do
    alice = users(:alice)
    bob = users(:bob)

    assert Relationship.find_by(follower_id: users(:alice).id, following_id: users(:bob).id).blank?
    alice.follow(bob)
    assert Relationship.find_by(follower_id: users(:alice).id, following_id: users(:bob).id).present?
  end

  test '#following?' do
    alice = users(:alice)
    bob = users(:bob)

    assert_not alice.following?(bob)
    Relationship.create(follower_id: users(:alice).id, following_id: users(:bob).id)
    assert alice.following?(bob)
  end

  test '#followed_by?' do
    alice = users(:alice)
    bob = users(:bob)

    assert_not bob.followed_by?(alice)
    Relationship.create(follower_id: users(:alice).id, following_id: users(:bob).id)
    assert bob.followed_by?(alice)
  end

  test '#unfollow' do
    alice = users(:alice)
    bob = users(:bob)

    Relationship.create(follower_id: users(:alice).id, following_id: users(:bob).id)
    assert Relationship.find_by(follower_id: users(:alice).id, following_id: users(:bob).id).present?
    alice.unfollow(bob)
    assert Relationship.find_by(follower_id: users(:alice).id, following_id: users(:bob).id).blank?
  end
end
