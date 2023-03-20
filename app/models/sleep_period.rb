class SleepPeriod < Sequel::Model
  many_to_one :user

  def validate
    super

    errors.add(:wake_up, :less_than_fall_asleep) if wake_up.present? && wake_up < fall_asleep
  end
end
