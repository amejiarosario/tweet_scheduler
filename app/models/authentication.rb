class Authentication
  include Mongoid::Document
  field :provider,    type: String
  field :uid,         type: String
  field :token,       type: String
  field :secret,      type: String
  field :expires_at,  type: String
  field :data
  field :created_at,  type: DateTime, default: ->{ Time.now }
  field :updated_at, type: DateTime, default: ->{ Time.now }

  belongs_to :user

  validates :uid, presence: true
  validates :provider, presence: true
end