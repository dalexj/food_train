class TrainOption < ActiveRecord::Base
  belongs_to :train
  has_many :votes
  has_one :yelp_business

  validates :place, presence: true

  before_create :set_yelp_business

  def vote_count
    votes.count
  end

  def yelp_content
"<p>Rating:  #{yelp_business.rating}</p>
<p>Phone:    #{yelp_business.phone}</p>
<p>Address:  #{yelp_business.address}</p>
<p>Category: #{yelp_business.category}</p>"
  end

  def set_yelp_business
    self.yelp_business = YelpReader.create(train_option: self)
    true
  end
end
