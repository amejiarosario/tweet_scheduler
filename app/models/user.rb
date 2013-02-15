class User
  include Mongoid::Document
  field :name,       type: String
  field :nickname,   type: String
  field :email,      type: String
  field :created_at, type: DateTime, default: ->{ Time.now }
  field :updated_at, type: DateTime, default: ->{ Time.now }

  has_many :authentications, dependent: :destroy

  validate :present_username?

  def save(oauth=nil)
    update_user_info(oauth) if oauth
    save_result = super()
    if oauth && save_result
      begin
        create_authentication!(oauth)
      rescue => e
        self.errors(:authentications, e.message)
        return false
      end
    end
    save_result
  end

  def update_user_info(oauth)
    new_name = oauth.try(:[],'info').try(:[],'name')
    new_nickname = oauth.try(:[],'info').try(:[],'nickname')
    new_email = oauth.try(:[],'info').try(:[],'email')

    self.name = new_name unless new_name.blank?
    self.nickname = new_nickname unless new_nickname.blank?
    self.email = new_email unless new_email.blank?
  end

  def create_authentication!(oauth)
    expires = Time.at(oauth['credentials']['expires_at']) rescue nil
    authentications.create!(provider: oauth['provider'],
                            uid: oauth['uid'],
                            token: oauth['credentials']['token'],
                            secret: oauth['credentials'].try(:[],'secret'),
                            expires_at: expires,
                            data: oauth.to_json.to_s)
  end

  def username
    self.name || self.nickname
  end

  private
    def present_username?
      !username.blank?
    end
end
