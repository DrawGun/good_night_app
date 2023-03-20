module SleepPeriods
  class WakeUpParamsContract < Dry::Validation::Contract
    params do
      required(:sleep_period_id).value(:integer)
      required(:sleep_period).hash do
        required(:wake_up).value(:time)
      end
    end
  end
end
