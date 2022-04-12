# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    carol = users(:carol)
    assert_equal 'carol@example.com', carol.name_or_email

    carol.name = 'Carol'
    assert_equal 'Carol', carol.name_or_email
  end

  test '#follow_and_#following?' do
    alice = users(:alice)
    bob = users(:bob)

    assert_not alice.following?(bob)
    alice.follow(bob)
    assert alice.following?(bob)
  end

  test '#followed_by?' do
    alice = users(:alice)
    bob = users(:bob)

    assert_not bob.followed_by?(alice)
    alice.follow(bob)
    assert bob.followed_by?(alice)
  end

  test '#unfollow' do
    alice = users(:alice)
    bob = users(:bob)

    alice.follow(bob)
    assert alice.following?(bob)
    alice.unfollow(bob)
    assert_not alice.following?(bob)
  end
end
