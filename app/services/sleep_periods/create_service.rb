module SleepPeriods
  class CreateService
    prepend BasicService

    option :sleep_period_params do
      option :user_id
      option :fall_asleep
      option :wake_up, optional: true
    end

    attr_reader :sleep_period

    def call
      @sleep_period = ::SleepPeriod.new(sleep_period_params.to_h)
      calculate_value_service = SleepPeriods::CalculateValueService.call(sleep_period: sleep_period)
      sleep_period.value = calculate_value_service.value if calculate_value_service.success?

      if sleep_period.valid?
        sleep_period.save
      else
        fail!(sleep_period.errors)
      end
    end
  end
end
