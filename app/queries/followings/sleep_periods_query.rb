module Followings
  class SleepPeriodsQuery
    def initialize(user:, date: 7.days.ago)
      @user = user
      @date = date
    end

    def call
      user_ids = user.followees_dataset.select_map(:followee_id)
      SleepPeriod.where(user_id: user_ids).where(Sequel[:fall_asleep] > date).reverse_order(:value)
    end

    private

    attr_reader :user, :date
  end
end
