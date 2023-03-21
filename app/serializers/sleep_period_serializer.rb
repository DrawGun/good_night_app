class SleepPeriodSerializer
  include FastJsonapi::ObjectSerializer

  attributes :value, :created_at

  attributes :fall_asleep_info do |object|
    object.fall_asleep.strftime('%Y-%m-%d %H:%M')
  end

  attributes :wake_up_info do |object|
    object.wake_up.strftime('%Y-%m-%d %H:%M') if object.wake_up.present?
  end
end
