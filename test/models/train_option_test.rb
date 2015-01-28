require "test_helper"

class TrainOptionTest < ActiveSupport::TestCase

  def test_belongs_to_a_train
    train = create_train
    pizza_option = create_train_option(place: "Pizza", train: train)
    sushi_option = create_train_option(place: "Sushi", train: train)
    assert_equal pizza_option.train, train
    assert_equal sushi_option.train, train
  end

  def test_train_option_can_have_many_votes
    train = create_train
    pizza_option = create_train_option(place: "Pizza", train: train)
    sushi_option = create_train_option(place: "Sushi", train: train)
    create_vote(train_option: pizza_option)
    create_vote(train_option: pizza_option)
    create_vote(train_option: sushi_option)

    assert_equal 1, sushi_option.votes.count
    assert_equal 2, pizza_option.votes.count
  end

  def test_train_option_vote_count
    option = create_train_option
    5.times { create_vote(train_option: option) }
    assert_equal 5, option.vote_count
  end

  def test_train_option_creates_a_yelp_business
    train_option = create_train_option
    assert train_option.yelp_business
  end

  def test_train_option_validates_place_presence
    train_option = create_train_option
    assert train_option.valid?
    train_option.place = nil
    refute train_option.valid?
    train_option.place = ""
    refute train_option.valid?
  end

end
