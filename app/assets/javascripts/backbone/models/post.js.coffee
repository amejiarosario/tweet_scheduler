class TweetScheduler.Models.Post extends Backbone.Model
  paramRoot: 'post'
  idAttribute: '_id'

  defaults:
    message: null
    publish_on: null

class TweetScheduler.Collections.PostsCollection extends Backbone.Collection
  model: TweetScheduler.Models.Post
  url: '/posts'
