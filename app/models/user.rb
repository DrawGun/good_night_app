class User < Sequel::Model
  one_to_many :sleep_periods
  one_to_many :followers, class: :Following, key: :followee_id
  one_to_many :followees, class: :Following, key: :follower_id

  def validate
    super

    validates_presence :name, message: I18n.t(:blank, scope: 'model.errors.user.name')
  end
end
