RSpec.describe SleepPeriods::CalculateValueService do
  subject { described_class }

  context 'valid parameters' do
    let(:sleep_period) { create(:sleep_period, value: nil) }

    it 'calculates value' do
      result = subject.call(sleep_period: sleep_period)

      expect(result.value).to eq(sleep_period.wake_up.to_i - sleep_period.fall_asleep.to_i)
    end
  end

  context 'invalid parameters' do
    let(:sleep_period) { create(:sleep_period, wake_up: nil, value: nil) }

    it 'adds empty_wake_up error' do
      result = subject.call(sleep_period: sleep_period)

      expect(result.success?).to be_falsey
      expect(result.errors).to eq(['Empty wake up'])
    end

    it 'adds same_value error' do
      sleep_period.update(wake_up: 1.day.ago, value: 1.days.ago.to_i - 2.days.ago.to_i).reload

      result = subject.call(sleep_period: sleep_period)

      expect(result.success?).to be_falsey
      expect(result.errors).to eq(['Same value'])
    end
  end
end
