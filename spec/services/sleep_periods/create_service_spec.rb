RSpec.describe SleepPeriods::CreateService do
  subject { described_class }

  let(:user) { create(:user) }

  context 'valid parameters' do
    let(:sleep_period_params) {
      {
        user_id: user.id,
        fall_asleep: 2.days.ago
      }
    }

    it 'calculates value' do
      expect {
        subject.call(sleep_period_params: sleep_period_params)
      }.to change { SleepPeriod.count }.from(0).to(1)
    end

    it 'assigns sleep_period' do
      result = subject.call(sleep_period_params: sleep_period_params)

      expect(result.sleep_period).to be_kind_of(SleepPeriod)
    end
  end

  context 'invalid parameters' do
    let(:sleep_period_params) {
      {
        user_id: user.id,
        fall_asleep: 2.days.ago,
        wake_up: 3.days.ago
      }
    }

    it 'does not create sleep_period' do
      expect {
        subject.call(sleep_period_params: sleep_period_params)
      }.not_to change { SleepPeriod.count }
    end

    it 'adds empty_wake_up error' do
      result = subject.call(sleep_period_params: sleep_period_params)

      expect(result.success?).to be_falsey
      expect(result.errors).to eq([{ wake_up: ['Must be after fall_asleep'] }])
    end
  end
end
