class User < Sequel::Model
  def validate
    super

    validates_presence :name, message: I18n.t(:blank, scope: 'model.errors.user.name')
  end
end
