# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    alice = users(:alice)
    report_of_alice = reports(:report_of_alice)
    report_of_bob = reports(:report_of_bob)

    assert report_of_alice.editable?(alice)
    assert_not report_of_bob.editable?(alice)
  end

  test '#created_on' do
    report_of_alice = reports(:report_of_alice)

    assert_not_equal '2022-04-10', report_of_alice.created_at.to_s
    assert_equal '2022-04-10', report_of_alice.created_on.to_s
  end
end
