class SleepPeriod < Sequel::Model
  many_to_one :user

  def validate
    super

    if wake_up.present? && wake_up < fall_asleep
      messages = I18n.t(:less_than_fall_asleep, scope: 'model.errors.sleep_period.wake_up')
      errors.add(:wake_up, messages)
    end
  end

  dataset_module do
    def completed
      exclude(wake_up: nil).exclude(value: nil)
    end

    def ordered
      reverse_order(:created_at)
    end
  end
end
