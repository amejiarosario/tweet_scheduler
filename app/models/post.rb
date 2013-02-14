class Post
  include Mongoid::Document
  field :message, type: String
  field :publish_on, type: Time, default: ->{ Time.now }
  field :sent, type: Boolean, default: false

  def self.tweets_ready
    Post.where(:publish_on.lte => Time.now, 
               sent: false).
    to_a
  end
end
