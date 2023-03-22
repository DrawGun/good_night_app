class Following < Sequel::Model
  many_to_one :follower, class: :User
  many_to_one :followee, class: :User

  def validate
    super

    validates_presence :follower_id, message: I18n.t(:blank, scope: 'model.errors.following.follower_id')
    validates_presence :followee_id, message: I18n.t(:blank, scope: 'model.errors.following.followee_id')
    validates_unique([:follower_id, :followee_id])

    if follower_id.present? && followee_id.present? && follower_id == followee_id
      messages = I18n.t(:can_not_be_same_as_follower, scope: 'model.errors.following.followee_id')
      errors.add(:followee_id, messages)
    end
  end
end
