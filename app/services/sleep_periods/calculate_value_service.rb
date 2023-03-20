module SleepPeriods
  class CalculateValueService
    prepend BasicService

    option :sleep_period
    option :scope, default: -> { 'services.sleep_periods.calculate_value_service' }

    attr_reader :value

    def call
      return fail_t!(:empty_wake_up) if sleep_period.wake_up.blank?

      @value = sleep_period.wake_up.to_i - sleep_period.fall_asleep.to_i

      return fail_t!(:same_value) if sleep_period.value == value
    end
  end
end
