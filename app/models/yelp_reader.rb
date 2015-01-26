class YelpReader
  def self.search_for_restaurant(restaurant)
    # sort is 1 for closest to denver, 0 for best match to term
    search = Yelp.client.search 'Denver', term: restaurant, sort: 1
    search.businesses.first
  end

  def self.create(train_option: )
    if test_mode?
      YelpBusiness.create rating: "4", phone: "123-456-7890", address: "12345 fake st",
                          category: "food", train_option_id: train_option.id
    else
      business = search_for_restaurant(train_option.place)
      YelpBusiness.create rating: business.rating, phone: business.display_phone,
                          train_option_id: train_option.id, address: business.location.address.first,
                          category: business.categories.first.first
    end
  end

  def self.test_mode=(test_mode)
    @test_mode = test_mode
  end

  def self.test_mode?
    @test_mode
  end
end
