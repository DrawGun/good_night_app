module Followings
  class FollowService
    prepend BasicService

    option :follower_id
    option :followee_id
    option :follower, default: -> { User.first(id: follower_id) }
    option :followee, default: -> { User.first(id: followee_id) }
    option :scope, default: -> { 'services.followings.follow_service' }

    attr_reader :following

    def call
      return fail_t!(:follower_is_not_found) if follower.blank?
      return fail_t!(:followee_is_not_found) if followee.blank?

      @following = ::Following.new({
        follower_id: follower_id,
        followee_id: followee_id
      })

      if following.valid?
        following.save
      else
        fail!(following.errors)
      end
    end
  end
end
