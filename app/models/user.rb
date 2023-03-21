class User < Sequel::Model
  one_to_many :sleep_periods
  one_to_many :followers, class: :Follower, key: :follower_id
  one_to_many :followeds, class: :Follower, key: :followed_id

  def validate
    super

    validates_presence :name, message: I18n.t(:blank, scope: 'model.errors.user.name')
  end
end
