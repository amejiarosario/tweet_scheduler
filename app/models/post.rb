class Post
  include Mongoid::Document
  field :message, type: String
  field :publish_on, type: Time, default: ->{ Time.now }
  field :sent, type: Boolean, default: false

  scope :unsent, where(sent: false)
  scope :expired, where(:publish_on.lte => Time.now)
  scope :ready, where(:publish_on.lte => Time.now, sent: false)

  belongs_to :user

  def self.tweets_ready
    Post.where(:publish_on.lte => Time.now, sent: false).to_a
  end
end
