RSpec.describe SleepPeriodSerializer do
  subject { described_class.new(sleep_period) }

  let(:sleep_period) { create(:sleep_period) }

  let(:attributes) do
    {
      value: sleep_period.value,
      fall_asleep_info: sleep_period.fall_asleep.strftime('%Y-%m-%d %H:%M'),
      wake_up_info: sleep_period.wake_up.strftime('%Y-%m-%d %H:%M')
    }
  end

  it 'returns sleep_period representation' do
    expect(subject.serializable_hash).to a_hash_including(
      data: {
        id: sleep_period.id.to_s,
        type: :sleep_period,
        attributes: attributes
      }
    )
  end
end
