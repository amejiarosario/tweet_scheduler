class Post
  include Mongoid::Document
  field :message, type: String
  field :publish_on, type: Time
end
