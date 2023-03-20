RSpec.describe SleepPeriods::WakeUpService do
  subject { described_class }

  let!(:sleep_period) { create(:sleep_period, wake_up: nil, value: nil) }
  let(:data) {
    {
      wake_up: 1.day.ago
    }
  }

  context 'valid parameters' do
    it 'updates wake_up and value for sleep_period' do
      result = subject.call(id: sleep_period.id, data: data)

      expect(sleep_period.reload.wake_up).to_not be_nil
      expect(sleep_period.reload.value).to eq(sleep_period.wake_up.to_i - sleep_period.fall_asleep.to_i)
    end
  end

  context 'invalid parameters' do
    it 'returns not_found error' do
      result = subject.call(id: SleepPeriod.last.id + 100, data: data)

      expect(result.success?).to be_falsey
      expect(result.errors).to eq(['Not found'])
    end

    it 'returns already_exists error' do
      sleep_period.update(wake_up: 1.day.ago).reload
      result = subject.call(id: sleep_period.id, data: data)

      expect(result.success?).to be_falsey
      expect(result.errors).to eq(['Already exists'])
    end
  end
end
