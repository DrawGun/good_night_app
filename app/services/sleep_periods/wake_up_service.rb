module SleepPeriods
  class WakeUpService
    prepend BasicService

    option :id
    option :data
    option :sleep_period, default: -> { SleepPeriod.first(id: id) }
    option :scope, default: -> { 'services.sleep_periods.wake_up_service' }

    def call
      return fail_t!(:not_found) if sleep_period.blank?
      return fail_t!(:already_exists) if sleep_period.value.present?

      sleep_period.wake_up = data[:wake_up]
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
