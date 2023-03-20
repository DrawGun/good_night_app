class User < Sequel::Model
  one_to_many :sleep_periods

  def validate
    super

    validates_presence :name, message: I18n.t(:blank, scope: 'model.errors.user.name')
  end
end
