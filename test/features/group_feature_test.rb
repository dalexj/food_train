require "test_helper"

class GroupFeatureTest < Capybara::Rails::TestCase
  def test_group_index_shows_all
    5.times { |n| create_group name: "testgroup #{n}" }
    visit groups_path
    5.times do |n|
      assert_content page, "testgroup #{n}"
    end
  end

  def test_can_make_a_new_group
    # k
  end

  def test_shows_errors_when_making_group_with_no_name
    # this may not even be implemented yet
    # k
  end

  def test_can_delete_a_group
    # k
  end

  def test_can_only_delete_group_if_you_are_owner
    # k
  end

  def test_doesnt_break_when_deleting_group_that_doesnt_exist
    # k
  end

  def test_can_join_a_group
    # k
  end

  def test_can_leave_a_group
    # k
  end

  def test_cant_join_a_group_that_doesnt_exist
    # k
  end

  def test_cant_leave_a_group_that_doesnt_exist
    # k
  end
end
