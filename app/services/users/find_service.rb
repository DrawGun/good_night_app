module Users
  class FindService
    prepend BasicService

    option :id
    option :user, default: -> { User.first(id: id) }
    option :scope, default: -> { 'services.users.find_service' }

    def call
      fail_t!(:not_found) if user.blank?
    end
  end
end
