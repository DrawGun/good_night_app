class Follower < Sequel::Model
  many_to_one :follower, class: :User
  many_to_one :followed, class: :User

  def validate
    super

    validates_presence :follower_id, message: I18n.t(:blank, scope: 'model.errors.follower.follower_id')
    validates_presence :followed_id, message: I18n.t(:blank, scope: 'model.errors.follower.followed_id')
    validates_unique(:follower_id, :followed_id)
  end
end
