module Users
  class FriendsSleepPeriodService
    prepend BasicService

    option :id
    option :user, default: -> { User.first(id: id) }
    option :scope, default: -> { 'services.users.find_service' }

    attr_reader :value

    def call
      fail_t!(:not_found) if user.blank?
    end
  end
end
