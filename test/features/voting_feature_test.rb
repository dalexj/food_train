require "test_helper"

class VotingFeatureTest < Capybara::Rails::TestCase
  def test_can_not_vote_if_not_logged_in
    group = create_group
    train = create_train group: group
    pizza_option = create_train_option train: train, place: "Pizza"
    pizza_option2 = create_train_option train: train, place: "Pizza2"

    visit group_path(group)
    click_link_or_button "Vote for the Pizza Train"
    assert_equal group_path(group), current_path

    assert_equal 0, pizza_option.reload.vote_count
  end

  def test_can_increase_the_votes_when_logged_in
    group = create_group
    train = create_train group: group
    pizza_option = create_train_option train: train, place: "Pizza"
    pizza_option2 = create_train_option train: train, place: "Pizza2"

    log_in
    user = User.find_or_create_from_auth_hash(auth_hash)
    group.users << user

    visit group_path(group)
    click_link_or_button "Vote for the Pizza Train"

    assert_equal 1, pizza_option.reload.vote_count
  end

  def test_voting_for_an_option_that_doesnt_exist_gives_error
    group = create_group
    train = create_train group: group
    pizza_option = create_train_option train: train, place: "Pizza"
    deleted_option = create_train_option train: train, place: "Deleted"

    log_in
    user = User.find_or_create_from_auth_hash(auth_hash)
    group.users << user

    visit group_path(group)
    deleted_option.delete
    click_link_or_button "Vote for the Deleted Train"

    assert_content page, "option does not exist"
  end
end
