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

    assert alice.active_relationships.where(following: bob).empty?
    alice.follow(bob)
    assert alice.active_relationships.where(following: bob).exists?
  end

  test '#following?' do
    alice = users(:alice)
    bob = users(:bob)

    assert_not alice.following?(bob)
    alice.active_relationships.create(following: bob)
    assert alice.following?(bob)
  end

  test '#followed_by?' do
    alice = users(:alice)
    bob = users(:bob)

    assert_not bob.followed_by?(alice)
    alice.active_relationships.create(following: bob)
    assert bob.followed_by?(alice)
  end

  test '#unfollow' do
    alice = users(:alice)
    bob = users(:bob)

    alice.active_relationships.create(following: bob)
    assert alice.active_relationships.where(following: bob).exists?
    alice.unfollow(bob)
    assert alice.active_relationships.where(following: bob).empty?
  end
end
