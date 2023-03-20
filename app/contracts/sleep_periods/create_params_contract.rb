module SleepPeriods
  class CreateParamsContract < Dry::Validation::Contract
    params do
      required(:sleep_period).hash do
        required(:user_id).value(:integer)
        required(:fall_asleep).value(:time)
        optional(:wake_up).value(:time)
      end
    end
  end
end
